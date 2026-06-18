package jadx.cli.tools;

import java.util.LinkedHashMap;
import java.util.Map;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.ParameterException;

import jadx.cli.tools.dev.DevSubcommand;
import jadx.cli.tools.dev.DumpCfgTool;
import jadx.cli.tools.dev.ExportSmaliTool;
import jadx.cli.tools.dev.InspectMethodTool;
import jadx.cli.tools.dev.ListVisitorsTool;

/**
 * Developer utilities for exporting smali fixtures, dumping CFG, and inspecting methods.
 *
 * <p>Prefer {@code scripts/jadx-dev.sh} wrapper from repo root.
 */
public final class JadxDev {

	private JadxDev() {
	}

	public static void main(String[] args) {
		ExportSmaliTool exportSmali = new ExportSmaliTool();
		DumpCfgTool dumpCfg = new DumpCfgTool();
		InspectMethodTool inspectMethod = new InspectMethodTool();
		ListVisitorsTool listVisitors = new ListVisitorsTool();

		Map<String, DevSubcommand> commands = new LinkedHashMap<>();
		register(commands, exportSmali);
		register(commands, dumpCfg);
		register(commands, inspectMethod);
		register(commands, listVisitors);

		JCommander.Builder builder = JCommander.newBuilder().programName("jadx-dev");
		for (Map.Entry<String, DevSubcommand> entry : commands.entrySet()) {
			builder.addCommand(entry.getKey(), entry.getValue());
		}
		JCommander commander = builder.build();
		try {
			commander.parse(args);
		} catch (ParameterException e) {
			System.err.println(e.getMessage());
			commander.usage();
			System.exit(1);
			return;
		}
		String parsedCommand = commander.getParsedCommand();
		if (parsedCommand == null) {
			commander.usage();
			System.exit(1);
			return;
		}
		DevSubcommand cmd = commands.get(parsedCommand);
		cmd.run();
	}

	private static void register(Map<String, DevSubcommand> commands, DevSubcommand cmd) {
		commands.put(cmd.name(), cmd);
	}
}
