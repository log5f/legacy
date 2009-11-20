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
			logger.debug("Some Information Message");
		}

		public function testWarning():void
		{
			logger.debug("Some Warning Message");
		}

		public function testError():void
		{
			logger.debug("Some Error Message");
		}

		public function testFatalError():void
		{
			logger.debug("Some Fatal Error Message");
		}
	}
}