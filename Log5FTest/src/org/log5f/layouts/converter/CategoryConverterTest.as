package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import org.log5f.Category;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.converters.CategoryConverter;

	public class CategoryConverterTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function CategoryConverterTest()
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
			var event:LogEvent = new LogEvent(new Category("org.xxx.yyy.zzz"), Level.DEBUG, "");
			
			Assert.assertEquals("", "org.xxx.yyy.zzz", new CategoryConverter(0).convert(event));
			Assert.assertEquals("", "zzz", new CategoryConverter(1).convert(event));
			Assert.assertEquals("", "yyy.zzz", new CategoryConverter(2).convert(event));
			Assert.assertEquals("", "xxx.yyy.zzz", new CategoryConverter(3).convert(event));
			Assert.assertEquals("", "org.xxx.yyy.zzz", new CategoryConverter(4).convert(event));
			Assert.assertEquals("", "org.xxx.yyy.zzz", new CategoryConverter(5).convert(event));
			Assert.assertEquals("", "org.xxx.yyy.zzz", new CategoryConverter(6).convert(event));
			Assert.assertEquals("", "org.xxx.yyy.zzz", new CategoryConverter(7).convert(event));
			Assert.assertEquals("", "org.xxx.yyy.zzz", new CategoryConverter(8).convert(event));
			Assert.assertEquals("", "org.xxx.yyy.zzz", new CategoryConverter(9).convert(event));
		}
	}
}