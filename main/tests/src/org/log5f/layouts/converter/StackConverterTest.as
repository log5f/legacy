package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.converters.StackConverter;
	import org.log5f.layouts.converters.StackPart;

	public class StackConverterTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function StackConverterTest()
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
			var event:LogEvent
			
			stack = 
				"Error\n" +
				"	at org.log5f::Category/http://code.google.com/p/log5f::log()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:366]\n" + 
				"	at org.log5f::Category/debug()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:300]\n" +
				"	at my.test::Test/my()[C:\Labs\Log5FTest\src\my\test\Test.as:21]\n" +
				"	at my.test::Test()[C:\Labs\Log5FTest\src\my\test\Test.as:14]\n" +
				"	at Log5FTest/applicationCompleteHandler()[C:\Labs\Log5FTest\src\Log5FTest.mxml:16]\n" +
				"	at Log5FTest/___Log5FTest_Application1_applicationComplete()[C:\Labs\Log5FTest\src\Log5FTest.mxml:6]\n" +
				"	at flash.events::EventDispatcher/dispatchEventFunction()\n" +
				"	at flash.events::EventDispatcher/dispatchEvent()\n" +
				"	at mx.core::UIComponent/dispatchEvent()[E:\dev\beta1\frameworks\projects\framework\src\mx\core\UIComponent.as:11260]\n" +
				"	at mx.managers::SystemManager/preloader_preloaderDoneHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\managers\SystemManager.as:3327]\n" +
				"	at flash.events::EventDispatcher/dispatchEventFunction()\n" +
				"	at flash.events::EventDispatcher/dispatchEvent()\n" +
				"	at mx.preloaders::Preloader/displayClassCompleteHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\Preloader.as:454]\n" +
				"	at flash.events::EventDispatcher/dispatchEventFunction()\n" +
				"	at flash.events::EventDispatcher/dispatchEvent()\n" +
				"	at mx.preloaders::SparkDownloadProgressBar/initCompleteHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\SparkDownloadProgressBar.as:900]\n" +
				"	at flash.events::EventDispatcher/dispatchEventFunction()\n" +
				"	at flash.events::EventDispatcher/dispatchEvent()\n" +
				"	at mx.preloaders::Preloader/dispatchAppEndEvent()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\Preloader.as:311]\n" +
				"	at mx.preloaders::Preloader/appCreationCompleteHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\Preloader.as:462]\n" +
				"	at flash.events::EventDispatcher/dispatchEventFunction()\n" +
				"	at flash.events::EventDispatcher/dispatchEvent()\n" +
				"	at mx.core::UIComponent/dispatchEvent()[E:\dev\beta1\frameworks\projects\framework\src\mx\core\UIComponent.as:11260]\n" +
				"	at mx.core::UIComponent/set initialized()[E:\dev\beta1\frameworks\projects\framework\src\mx\core\UIComponent.as:1513]\n" +
				"	at mx.managers::LayoutManager/doPhasedInstantiation()[E:\dev\beta1\frameworks\projects\framework\src\mx\managers\LayoutManager.as:759]\n" +
				"	at mx.managers::LayoutManager/doPhasedInstantiationCallback()[E:\dev\beta1\frameworks\projects\framework\src\mx\managers\LayoutManager.as:1067]";
			
			event = new LogEvent(null, Level.DEBUG, "", stack); 
			
			Assert.assertEquals("my.test", new StackConverter(StackPart.PACKAGE_NAME).convert(event));
			Assert.assertEquals("Test", new StackConverter(StackPart.CLASS_NAME).convert(event));
			Assert.assertEquals("my", new StackConverter(StackPart.METHOD_NAME).convert(event));
			Assert.assertEquals("C:\Labs\Log5FTest\src\my\test\Test.as", new StackConverter(StackPart.FILE_NAME).convert(event));
			Assert.assertEquals("21", new StackConverter(StackPart.LINE_NUMBER).convert(event));
			
			stack = 
				"Error\n" + 
	     		"	at org.log5f::Category/http://code.google.com/p/log5f::log()[C:\Applications\Workspace\Log5F\src\org\log5f\Category.as:366]\n" + 
	     		"	at org.log5f::Category/debug()[C:\Applications\Workspace\Log5F\src\org\log5f\Category.as:300]\n" + 
	     		"	at TestRunner/applicationCompleteHandler()[C:\Applications\Workspace\Log5FTest\src\TestRunner.mxml:28]\n" + 
	     		"	at TestRunner/___TestRunner_Application1_applicationComplete()[C:\Applications\Workspace\Log5FTest\src\TestRunner.mxml:8]\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEventFunction()\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEvent()\n" + 
	     		"	at mx.core::UIComponent/dispatchEvent()[E:\dev\beta1\frameworks\projects\framework\src\mx\core\UIComponent.as:11260]\n" + 
	     		"	at mx.managers::SystemManager/preloader_preloaderDoneHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\managers\SystemManager.as:3327]\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEventFunction()\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEvent()\n" + 
	     		"	at mx.preloaders::Preloader/displayClassCompleteHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\Preloader.as:454]\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEventFunction()\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEvent()\n" + 
	     		"	at mx.preloaders::SparkDownloadProgressBar/initCompleteHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\SparkDownloadProgressBar.as:900]\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEventFunction()\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEvent()\n" + 
	     		"	at mx.preloaders::Preloader/dispatchAppEndEvent()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\Preloader.as:311]\n" + 
	     		"	at mx.preloaders::Preloader/appCreationCompleteHandler()[E:\dev\beta1\frameworks\projects\framework\src\mx\preloaders\Preloader.as:462]\n" + 
	     		"	at flash.events::EventDispatcher/dispatchEventFunction()	at flash.events::EventDispatcher/dispatchEvent()\n" + 
	     		"	at mx.core::UIComponent/dispatchEvent()[E:\dev\beta1\frameworks\projects\framework\src\mx\core\UIComponent.as:11260]\n" + 
	     		"	at mx.core::UIComponent/set initialized()[E:\dev\beta1\frameworks\projects\framework\src\mx\core\UIComponent.as:1513]\n" + 
	     		"	at mx.managers::LayoutManager/doPhasedInstantiation()[E:\dev\beta1\frameworks\projects\framework\src\mx\managers\LayoutManager.as:759]\n" + 
	     		"	at mx.managers::LayoutManager/doPhasedInstantiationCallback()[E:\dev\beta1\frameworks\projects\framework\src\mx\managers\LayoutManager.as:1067]";
			
			event = new LogEvent(null, Level.DEBUG, "", stack); 
			
			Assert.assertEquals(null, new StackConverter(StackPart.PACKAGE_NAME).convert(event));
			Assert.assertEquals("TestRunner", new StackConverter(StackPart.CLASS_NAME).convert(event));
			Assert.assertEquals("applicationCompleteHandler", new StackConverter(StackPart.METHOD_NAME).convert(event));
			Assert.assertEquals("C:\Applications\Workspace\Log5FTest\src\TestRunner.mxml", new StackConverter(StackPart.FILE_NAME).convert(event));
			Assert.assertEquals("28", new StackConverter(StackPart.LINE_NUMBER).convert(event));
		}
	}
}