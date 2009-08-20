package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.coverters.CategoryConverter;
	import org.log5f.layouts.coverters.LevelConverter;

	public class LevelConverterTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function LevelConverterTest()
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
			var event:LogEvent
			 
			event = new LogEvent(null, Level.DEBUG, "");
			
			Assert.assertEquals("", "DEBUG", new LevelConverter(0).convert(event));
			Assert.assertEquals("", "D", new LevelConverter(1).convert(event));
			Assert.assertEquals("", "DE", new LevelConverter(2).convert(event));
			Assert.assertEquals("", "DEB", new LevelConverter(3).convert(event));
			Assert.assertEquals("", "DEBU", new LevelConverter(4).convert(event));
			Assert.assertEquals("", "DEBUG", new LevelConverter(5).convert(event));
			Assert.assertEquals("", "DEBUG ", new LevelConverter(6).convert(event));
			Assert.assertEquals("", "DEBUG  ", new LevelConverter(7).convert(event));
			Assert.assertEquals("", "DEBUG   ", new LevelConverter(8).convert(event));
			Assert.assertEquals("", "DEBUG    ", new LevelConverter(9).convert(event));
		}
	}
}