package org.log5f.demos.test
{
	import org.log5f.Logger;
	import org.log5f.LoggerManager;

	public class SomeTestClass
	{
		private static const logger:Logger = 
			LoggerManager.getLogger(SomeTestClass);
		
		public function SomeTestClass()
		{
			super();
		}
		
		public function testDebug():void
		{
			logger.debug("Some Debug Message");
		}

		public function testInformation():void
		{
			logger.info("Some Information Message");
		}

		public function testWarning():void
		{
			logger.warn("Some Warning Message");
		}

		public function testError():void
		{
			logger.error("Some Error Message");
		}

		public function testFatalError():void
		{
			logger.fatal("Some Fatal Error Message");
		}
	}
}