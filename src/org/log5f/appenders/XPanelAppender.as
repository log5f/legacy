package org.log5f.appenders
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.getTimer;
	
	import org.log5f.IAppender;
	import org.log5f.ILayout;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	
	public class XPanelAppender implements IAppender
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const DEFAULT_CONNECTION_NAME:String	= "_xpanel1";
		
		// ---------------- PRIVATE FIELDS ---------------- //
		
		private var connection:LocalConnection;
		
		[ArrayElementType("org.log5f.IFilter")]
		private var filters:Array;
		
		private var _name:String;
		
		private var _layout:ILayout;
	
		private var _connectionName:String;

		// ------------------ CONSTRUCTOR ----------------- //

		public function XPanelAppender()
		{
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

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
		
		public function close():void
		{
			this.layout = null;
		}
		
		public function get connectionName():String
		{
			return this._connectionName || DEFAULT_CONNECTION_NAME;
		}
		
		public function set connectionName(value:String):void
		{
			this._connectionName = value;
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
			
			var level:int;
			
			switch(event.level.toInt())
			{
				case Level.ALL.toInt()	 : level = 0x00; break;
				case Level.DEBUG.toInt() : level = 0x01; break;
				case Level.INFO.toInt()	 : level = 0x02; break;
				case Level.WARN.toInt()	 : level = 0x04; break;
				case Level.ERROR.toInt() : level = 0x08; break;
				case Level.FATAL.toInt() : level = 0x08; break;
				case Level.OFF.toInt()   : level = 0xFF; break;
			}
			
			this.connection.send(this.connectionName, "dispatchMessage", getTimer(), this.layout.format(event), level);
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
			trace("connectionSecurityErrorHandler");
		}

		// --------------- USER INTERACTION --------------- //
	}
}