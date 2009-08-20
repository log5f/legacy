package org.log5f.layouts.converter
{
	import flexunit.framework.Assert;
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.coverters.StackConverter;
	import org.log5f.layouts.coverters.StackPart;

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
			var callStack:String;
			var converter:StackConverter;
			
		     callStack = 
		     	"Error" + 
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
	
			converter = new StackConverter(StackPart.CLASS_NAME);
			
			Assert.assertEquals("", "TestRunner2", converter.convert(new LogEvent(null, Level.DEBUG, "", callStack)));
		}
	}
}