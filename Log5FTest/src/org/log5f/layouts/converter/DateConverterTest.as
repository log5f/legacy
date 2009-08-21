package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import mx.formatters.DateFormatter;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.coverters.DateConverter;

	public class DateConverterTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function DateConverterTest()
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
			var event:LogEvent = new LogEvent(null, Level.DEBUG, "");
			
			var formatter:DateFormatter = new DateFormatter();
			
			formatter.formatString = "YYYY/MM/DD J:NN:SS";
			
			Assert.assertEquals("", formatter.format(new Date), new DateConverter("ABSOLUTE").convert(event));

			formatter.formatString = "dd MMM yyyy HH:mm:ss,SSS";
			
			Assert.assertEquals("", formatter.format(new Date), new DateConverter("dd MMM yyyy HH:mm:ss,SSS").convert(event));
		}
	}
}