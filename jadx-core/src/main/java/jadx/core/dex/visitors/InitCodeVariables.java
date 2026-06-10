package jadx.core.dex.visitors;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import org.jetbrains.annotations.Nullable;

import jadx.core.dex.attributes.AFlag;
import jadx.core.dex.instructions.InsnType;
import jadx.core.dex.instructions.IndexInsnNode;
import jadx.core.dex.instructions.PhiInsn;
import jadx.core.dex.instructions.args.ArgType;
import jadx.core.dex.instructions.args.CodeVar;
import jadx.core.dex.instructions.args.RegisterArg;
import jadx.core.dex.instructions.args.SSAVar;
import jadx.core.dex.instructions.mods.ConstructorInsn;
import jadx.core.dex.nodes.InsnNode;
import jadx.core.dex.nodes.MethodNode;
import jadx.core.dex.visitors.ssa.SSATransform;
import jadx.core.utils.exceptions.JadxException;

@JadxVisitor(
		name = "InitCodeVariables",
		desc = "Initialize code variables",
		runAfter = SSATransform.class
)
public class InitCodeVariables extends AbstractVisitor {

	@Override
	public void visit(MethodNode mth) throws JadxException {
		initCodeVars(mth);
	}

	public static void rerun(MethodNode mth) {
		for (SSAVar sVar : mth.getSVars()) {
			sVar.resetTypeAndCodeVar();
		}
		initCodeVars(mth);
	}

	private static void initCodeVars(MethodNode mth) {
		RegisterArg thisArg = mth.getThisArg();
		if (thisArg != null) {
			initCodeVar(mth, thisArg);
		}
		for (RegisterArg mthArg : mth.getArgRegs()) {
			initCodeVar(mth, mthArg);
		}
		for (SSAVar ssaVar : mth.getSVars()) {
			initCodeVar(ssaVar);
		}
	}

	public static void initCodeVar(MethodNode mth, RegisterArg regArg) {
		SSAVar ssaVar = regArg.getSVar();
		if (ssaVar == null) {
			ssaVar = mth.makeNewSVar(regArg);
		}
		initCodeVar(ssaVar);
	}

	public static void initCodeVar(SSAVar ssaVar) {
		if (ssaVar.isCodeVarSet()) {
			return;
		}
		CodeVar codeVar = new CodeVar();
		RegisterArg assignArg = ssaVar.getAssign();
		if (assignArg.contains(AFlag.THIS)) {
			codeVar.setName(RegisterArg.THIS_ARG_NAME);
			codeVar.setThis(true);
		}
		if (assignArg.contains(AFlag.METHOD_ARGUMENT) || assignArg.contains(AFlag.CUSTOM_DECLARE)) {
			codeVar.setDeclared(true);
		}

		setCodeVar(ssaVar, codeVar);
	}

	private static void setCodeVar(SSAVar ssaVar, CodeVar codeVar) {
		List<PhiInsn> phiList = ssaVar.getPhiList();
		if (!phiList.isEmpty()) {
			Set<SSAVar> vars = new LinkedHashSet<>();
			vars.add(ssaVar);
			collectConnectedVars(phiList, vars);
			List<Set<SSAVar>> partitions = partitionByCompatibleTypes(vars);
			boolean split = partitions.size() > 1;
			for (Set<SSAVar> partition : partitions) {
				CodeVar partVar = split ? newCodeVarFromTemplate(partition) : codeVar;
				setCodeVarType(partVar, partition);
				for (SSAVar var : partition) {
					if (var.isCodeVarSet()) {
						partVar.mergeFlagsFrom(var.getCodeVar());
					}
					var.setCodeVar(partVar);
				}
			}
		} else {
			ssaVar.setCodeVar(codeVar);
		}
	}

	private static CodeVar newCodeVarFromTemplate(Set<SSAVar> partition) {
		CodeVar cv = new CodeVar();
		for (SSAVar var : partition) {
			RegisterArg assign = var.getAssign();
			if (assign.contains(AFlag.THIS)) {
				cv.setName(RegisterArg.THIS_ARG_NAME);
				cv.setThis(true);
			}
			if (assign.contains(AFlag.METHOD_ARGUMENT) || assign.contains(AFlag.CUSTOM_DECLARE)) {
				cv.setDeclared(true);
			}
		}
		return cv;
	}

	private static List<Set<SSAVar>> partitionByCompatibleTypes(Set<SSAVar> vars) {
		List<Set<SSAVar>> groups = new ArrayList<>();
		for (SSAVar var : vars) {
			Set<SSAVar> group = new LinkedHashSet<>();
			group.add(var);
			groups.add(group);
		}
		boolean changed = true;
		while (changed) {
			changed = false;
			outer: for (int i = 0; i < groups.size(); i++) {
				for (int j = i + 1; j < groups.size(); j++) {
					if (groupsCompatible(groups.get(i), groups.get(j))) {
						groups.get(i).addAll(groups.get(j));
						groups.remove(j);
						changed = true;
						break outer;
					}
				}
			}
		}
		return groups;
	}

	private static boolean groupsCompatible(Set<SSAVar> a, Set<SSAVar> b) {
		for (SSAVar va : a) {
			for (SSAVar vb : b) {
				if (!areTypesCompatible(getVarTypeHint(va), getVarTypeHint(vb))) {
					return false;
				}
			}
		}
		return true;
	}

	private static boolean areTypesCompatible(@Nullable ArgType a, @Nullable ArgType b) {
		if (a == null || b == null || !a.isTypeKnown() || !b.isTypeKnown()) {
			return true;
		}
		// Kotlin coroutines reuse one register for label ints and spilled object locals.
		if (a.isPrimitive() != b.isPrimitive()) {
			return false;
		}
		if (a.isPrimitive()) {
			return a.equals(b);
		}
		return true;
	}

	private static @Nullable ArgType getVarTypeHint(SSAVar var) {
		ArgType imType = var.getImmutableType();
		if (imType != null && imType.isTypeKnown()) {
			return imType;
		}
		ArgType initType = var.getAssign().getInitType();
		if (initType != null && initType.isTypeKnown()) {
			return initType;
		}
		InsnNode assignInsn = var.getAssignInsn();
		if (assignInsn == null) {
			return null;
		}
		switch (assignInsn.getType()) {
			case CONSTRUCTOR:
				return ((ConstructorInsn) assignInsn).getClassType().getType();
			case CHECK_CAST:
				if (assignInsn instanceof IndexInsnNode) {
					return ((IndexInsnNode) assignInsn).getIndexAsType();
				}
				break;
			case CONST:
				return assignInsn.getArg(0).getType();
			case MOVE:
				if (assignInsn.getArg(0).isRegister()) {
					SSAVar src = ((RegisterArg) assignInsn.getArg(0)).getSVar();
					if (src != null) {
						return getVarTypeHint(src);
					}
				}
				break;
			case PHI:
				break;
			default:
				if (assignInsn.getResult() != null) {
					ArgType resType = assignInsn.getResult().getInitType();
					if (resType != null && resType.isTypeKnown()) {
						return resType;
					}
				}
				break;
		}
		if (assignInsn.getResult() != null) {
			ArgType resType = assignInsn.getResult().getType();
			if (resType.isTypeKnown()) {
				return resType;
			}
		}
		return null;
	}

	private static void setCodeVarType(CodeVar codeVar, Set<SSAVar> vars) {
		if (vars.size() > 1) {
			List<ArgType> imTypes = vars.stream()
					.map(SSAVar::getImmutableType)
					.filter(Objects::nonNull)
					.filter(ArgType::isTypeKnown)
					.distinct()
					.collect(Collectors.toList());
			int imCount = imTypes.size();
			if (imCount == 1) {
				codeVar.setType(imTypes.get(0));
			}
		} else if (vars.size() == 1) {
			ArgType hint = getVarTypeHint(vars.iterator().next());
			if (hint != null && hint.isTypeKnown()) {
				codeVar.setType(hint);
			}
		}
	}

	private static void collectConnectedVars(List<PhiInsn> phiInsnList, Set<SSAVar> vars) {
		if (phiInsnList.isEmpty()) {
			return;
		}
		for (PhiInsn phiInsn : phiInsnList) {
			SSAVar resultVar = phiInsn.getResult().getSVar();
			if (vars.add(resultVar)) {
				collectConnectedVars(resultVar.getPhiList(), vars);
			}
			phiInsn.getArguments().forEach(arg -> {
				SSAVar sVar = ((RegisterArg) arg).getSVar();
				if (vars.add(sVar)) {
					collectConnectedVars(sVar.getPhiList(), vars);
				}
			});
		}
	}
}
