package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.converters.FileConverter;
	import org.log5f.layouts.converters.MethodConverter;

	public class MethodConverterTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function MethodConverterTest()
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
			
			Assert.assertEquals("my", new MethodConverter().convert(event));

			stack = 
				stack = 
				"Error\n" + 
	     		"	at org.log5f::Category/http://code.google.com/p/log5f::log()[C:\Applications\Workspace\Log5F\src\org\log5f\Category.as:366]\n" + 
	     		"	at org.log5f::Category/debug()[C:\Applications\Workspace\Log5F\src\org\log5f\Category.as:300]\n" + 
	     		"	at TestRunner/applicationCompleteHandler()[C:\Applications\Workspace\Log5FTest\src\TestRunner.mxml:28]\n" + 
	     		"	at TestRunner/___TestRunner_Application1_applicationComplete()[C:\Applications\Workspace\Log5FTest\src\TestRunner.mxml:8]"; 
			
			event = new LogEvent(null, Level.DEBUG, "", stack);
			
			Assert.assertEquals("applicationCompleteHandler", new MethodConverter().convert(event));
			
			stack = 
				"Error\n" +
				"	at org.log5f::Category/http://code.google.com/p/log5f::log()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:366]\n" + 
				"	at org.log5f::Category/debug()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:300]\n" +
				"	at my.test::Test()[C:\Labs\Log5FTest\src\my\test\Test.as:14]";
			
			event = new LogEvent(null, Level.DEBUG, "", stack);
			
			Assert.assertEquals("", new MethodConverter().convert(event));
		}
	}
}