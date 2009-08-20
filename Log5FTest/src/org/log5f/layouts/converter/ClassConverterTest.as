package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.coverters.ClassConverter;

	public class ClassConverterTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function ClassConverterTest()
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
			var stack:String;
			var event:LogEvent;
			
			stack = 
				"Error\n" +
				"	at org.log5f::Category/http://code.google.com/p/log5f::log()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:366]\n" + 
				"	at org.log5f::Category/debug()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:300]\n" +
				"	at my.test::Test/my()[C:\Labs\Log5FTest\src\my\test\Test.as:21]\n" +
				"	at my.test::Test()[C:\Labs\Log5FTest\src\my\test\Test.as:14]";
			
			event = new LogEvent(null, Level.DEBUG, "", stack);
			
			Assert.assertEquals("my.test.Test", new ClassConverter(0).convert(event));
			Assert.assertEquals("Test", new ClassConverter(1).convert(event));
			Assert.assertEquals("test.Test", new ClassConverter(2).convert(event));
			Assert.assertEquals("my.test.Test", new ClassConverter(3).convert(event));
			Assert.assertEquals("my.test.Test", new ClassConverter(4).convert(event));
			Assert.assertEquals("my.test.Test", new ClassConverter(5).convert(event));
			Assert.assertEquals("my.test.Test", new ClassConverter(6).convert(event));
		}
	}
}