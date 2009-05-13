package org.log5f.appenders
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import org.log5f.IAppender;
	import org.log5f.ILayout;
	import org.log5f.events.LogEvent;
	import org.log5f.events.SimpleLogEvent;
	
	public class PysarAppender implements IAppender
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const DEFAULT_CONNECTION_NAME:String	= "_PysarDefaultConnection";
		
		// ---------------- PRIVATE FIELDS ---------------- //

		private var connection:LocalConnection;
		
		[ArrayElementType("org.log5f.IFilter")]
		private var filters:Array;
		
		private var _name:String;
		
		private var _layout:ILayout;
		
		private var _connectionName:String;

		// ------------------ CONSTRUCTOR ----------------- //

		public function PysarAppender()
		{
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public function get name():String
		{
			return this._name;
		}
		
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		public function get layout():ILayout
		{
			return this._layout;
		}
		
		public function set layout(value:ILayout):void
		{
			this._layout = value;
		}
		
		public function get connectionName():String
		{
			return this._connectionName || DEFAULT_CONNECTION_NAME;
		}
		
		public function set connectionName(value:String):void
		{
			this._connectionName = value;
		}

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //
		
		public function close():void
		{
			this.layout = null;
		}
		
		public function doAppend(event:LogEvent):void
		{
			if(this.connection == null)
			{
				this.connection = new LocalConnection();
				this.connection.addEventListener(StatusEvent.STATUS, this.connectionStatusHandler);
				this.connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.connectionAsyncErrorHandler);
				this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.connectionSecurityErrorHandler);
			}
			
			var e:SimpleLogEvent = new SimpleLogEvent(event.category.category,
													  event.level.toInt(),
													  this.connectionName,
													  this.layout.format(event),
													  event.packageName,
													  event.className,
													  event.methodName);
			
			this.connection.send(this.connectionName, "log", e);
		}

		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		protected function connectionStatusHandler(event:StatusEvent):void
		{
//			trace("connectionStatusHandler");
		}
		protected function connectionAsyncErrorHandler(event:AsyncErrorEvent):void
		{
//			trace("connectionAsyncErrorHandler");
		}
		protected function connectionSecurityErrorHandler(event:SecurityErrorEvent):void
		{
//			trace("connectionSecurityErrorHandler");
		}

		// --------------- USER INTERACTION --------------- //


	}
}