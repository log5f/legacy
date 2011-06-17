package org.log5f.layouts
{
	import flexunit.framework.Assert;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;

	public class SimpleLayoutTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function SimpleLayoutTest()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//  Before and After
		//
		//----------------------------------------------------------------------

		[Before]
		public function runBeforeEveryTest():void 
		{
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
		}                    

		//----------------------------------------------------------------------
		//
		//  Tests
		//
		//----------------------------------------------------------------------
		
		[Test]
		public function format():void
		{
			var layout:SimpleLayout = new SimpleLayout();
			
			var event:LogEvent = new LogEvent(null, Level.DEBUG, "Message");
			
			Assert.assertEquals("", "DEBUG - Message\n", layout.format(event));
		}
	}
}