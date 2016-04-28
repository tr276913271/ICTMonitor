package ict.monitor.agent;

import org.junit.Test;

import junit.framework.Assert;

public class AgentContextTest {
	@Test
	public void initTest() {
		AgentContext context = new AgentContext();
		try {
			context.init();
			Assert.assertEquals(context.getServerIP(), "127.0.0.2");
			Assert.assertEquals(context.getServerPort(), 50505);
		} catch (Exception e) {
			e.printStackTrace();
			Assert.assertTrue(false);
		}

	}
}
