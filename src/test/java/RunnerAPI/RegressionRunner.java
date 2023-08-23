package RunnerAPI;

import com.intuit.karate.junit5.Karate;

public class RegressionRunner {

	@Karate.Test
	public Karate runTest() {
		// address for feature files
		// and tags
		return Karate.run("classpath:features").tags("@Regression");
	}
}
