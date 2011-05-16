package org.log5f.core.managers
{
	import flash.events.Event;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.log5f.Level;
	import org.log5f.log5f_internal;
	
	import test.Category;

	public class DeferredManagerTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test(async, timeout="500")]
		public function addLog():void
		{
			var category:Category = new Category("addLog");
			
			DeferredManager.log5f_internal::addLog(category, Level.DEBUG, "addLog");
			
			Async.handleEvent(this, category, "log", verify_addLog, 500, category);
			
			DeferredManager.log5f_internal::processLogs();
		}
		
		[Test(async, timeout="500")]
		public function processLogs():void
		{
			var category:Category = new Category("processLogs");
			
			DeferredManager.log5f_internal::addLog(category, Level.DEBUG, "processLogs");
			
			Async.handleEvent(this, category, "log", verify_processLogs, 500, category);
			
			DeferredManager.log5f_internal::processLogs();
		}
		
		[Test(async, timeout="500")]
		public function removeLogs():void
		{
			var category:Category = new Category("removeLogs");
			
			DeferredManager.log5f_internal::addLog(category, Level.DEBUG, "removeLogs");
			
			DeferredManager.log5f_internal::removeLogs();
			
			Async.registerFailureEvent(this, category, "log");
			
			DeferredManager.log5f_internal::processLogs();
		}
		
		private function verify_addLog(event:Event, data:Object=null):void
		{
			assertEquals("addLog", data.name);
		}
		
		private function verify_processLogs(event:Event, data:Object=null):void
		{
			assertEquals("processLogs", data.name);
		}

	}
}
