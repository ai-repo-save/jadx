package jadx.cli.tools.dev;

import java.util.List;

import com.beust.jcommander.Parameters;

import jadx.api.JadxArgs;
import jadx.core.Jadx;
import jadx.core.dex.visitors.IDexTreeVisitor;

@Parameters(commandDescription = "List decompiler pass (visitor) names for use with --until-visitor")
public class ListVisitorsTool implements DevSubcommand {

	@Override
	public String name() {
		return "list-visitors";
	}

	@Override
	public void run() {
		List<IDexTreeVisitor> passes = Jadx.getPassesList(new JadxArgs());
		for (int i = 0; i < passes.size(); i++) {
			IDexTreeVisitor pass = passes.get(i);
			System.out.printf("%3d  %s%n", i, pass.getName());
		}
	}
}
