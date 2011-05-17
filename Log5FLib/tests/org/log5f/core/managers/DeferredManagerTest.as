package org.log5f.core.managers
{
	import flash.events.Event;
	
	import mockolate.make;
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.verify;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.log5f.Level;
	import org.log5f.core.Category;
	import org.log5f.log5f_internal;
	
	public class DeferredManagerTest
	{		
		[Before(async)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(Category), Event.COMPLETE);
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
		
		[Test]
		public function addLog():void
		{
			var category:Category = make(Category);
			mock(category).method("log").args("test addLog() method");
			
			DeferredManager.log5f_internal::addLog(category, Level.DEBUG, "test addLog() method");
			
			DeferredManager.log5f_internal::proceedLogs();
			
			verify(category);
		}
		
		[Test]
		public function proceedLogs():void
		{
			var category:Category = make(Category);
			mock(category).method("log").args("test proceedLogs() method");
			
			DeferredManager.log5f_internal::addLog(category, Level.DEBUG, "test proceedLogs() method");
			
			DeferredManager.log5f_internal::proceedLogs();
			
			verify(category);
		}
		
		[Test]
		public function removeLogs():void
		{
			var category:Category = make(Category);
			mock("log").never();
			
			DeferredManager.log5f_internal::addLog(category, Level.DEBUG, "test removeLogs() method");
			
			DeferredManager.log5f_internal::removeLogs();
			
			DeferredManager.log5f_internal::proceedLogs();
		}
		
	}
}
