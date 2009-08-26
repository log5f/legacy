package org.log5f.appenders
{
	import flash.events.Event;
	import flash.net.LocalConnection;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.SimpleLayout;

	public class LocalConnectionAppenderTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function LocalConnectionAppenderTest()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//  Varaibles
		//
		//----------------------------------------------------------------------
		
		private var connection:LocalConnection;
		
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
		
		[Test(async,timeout="500")]
		public function append():void
		{
			this.connection = new LocalConnection();
			this.connection.allowDomain('*');
			this.connection.client = this;
			
			this.connection.client = new TestHelper();
			this.connection.client.asyncHandler = Async.asyncHandler(this, this.asyncHandler, 500);
			
			this.connection.connect("_myConnection");
			
			var appender:LocalConnectionAppender = new LocalConnectionAppender();
			appender.connectionName = "_myConnection";
			appender.methodName = "receiveLogEvent";
			appender.layout = new SimpleLayout();
			
			var event:LogEvent = new LogEvent(null, Level.DEBUG, "Hello World!");
			
			appender.doAppend(event);
		}
		
		private function asyncHandler(event:EventHelper, data:Object=null):void
		{
			Assert.assertEquals("", "DEBUG - Hello World!\n", event.message);
		}
	}
}
import flash.events.Event;

////////////////////////////////////////////////////////////////////////////////
//
//	Helpers
//
////////////////////////////////////////////////////////////////////////////////

class TestHelper
{
	public function receiveLogEvent(message:String):void
	{
		this.asyncHandler(new EventHelper(message));
	}
	
	public var asyncHandler:Function;
}

class EventHelper extends Event
{
	public function EventHelper(message:String)
	{
		super("logEventReceived");
		
		this.message = message;
	}
	
	public var message:String;
}