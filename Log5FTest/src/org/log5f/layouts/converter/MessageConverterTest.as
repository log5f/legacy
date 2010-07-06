package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.converters.FileConverter;
	import org.log5f.layouts.converters.MessageConverter;

	public class MessageConverterTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function MessageConverterTest()
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
		public function convert():void
		{
			var event:LogEvent = new LogEvent(null, Level.DEBUG, "My Message");
			
			Assert.assertEquals("My Message", new MessageConverter().convert(event));
		}
	}
}