////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.getTimer;
	
	import org.log5f.Level;
	import org.log5f.LoggerManager;
	import org.log5f.core.Appender;
	import org.log5f.events.LogEvent;

	/**
	 * The <code>XPanelAppender</code> appends log events to the
	 * XPanel's console.
	 *
	 * @see http://wiki.log5f.org/wiki/Appenders:XPanelAppender/
	 */
	public class XPanelAppender extends LocalConnectionAppender
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		/** Default connection name for XPanel */
		public static const DEFAULT_CONNECTION_NAME:String = "_xpanel1";

		/** Default method name for XPanel */
		public static const DEFAULT_METHOD_NAME:String = "dispatchMessage";
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/** Constructor */
		public function XPanelAppender()
		{
			super();
		}

		//----------------------------------------------------------------------
		//
		//	Overridden properties
		//
		//----------------------------------------------------------------------

		//-----------------------------------
		//	connectionName
		//-----------------------------------

		/** @inheritDoc */
		override public function get connectionName():String
		{
			var name:String = super.connectionName;
			
			if (!name || name == LocalConnectionAppender.DEFAULT_CONNECTION_NAME)
				return XPanelAppender.DEFAULT_CONNECTION_NAME;
			
			return name;
		}

		//-----------------------------------
		//	methodName
		//-----------------------------------

		/** @inheritDoc */
		override public function get methodName():String
		{
			var name:String = super.methodName;
			
			if (!name || name == LocalConnectionAppender.DEFAULT_METHOD_NAME)
				return XPanelAppender.DEFAULT_METHOD_NAME;
			
			return name;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overriden methods
		//
		//----------------------------------------------------------------------

		/** @inheritDoc */
		override protected function subAppend(event:LogEvent):void
		{
			if (!this.connection) return;
			
			var levels:Object = {};
			levels[Level.ALL.toString()] = 0x00;
			levels[Level.DEBUG.toString()] = 0x01;
			levels[Level.INFO.toString()] = 0x02;
			levels[Level.WARN.toString()] = 0x04;
			levels[Level.ERROR.toString()] = 0x08;
			levels[Level.FATAL.toString()] = 0x08;
			levels[Level.OFF.toString()] = 0xFF;
			
			var level:int = levels[event.level.toString()];
			
			try
			{
				this.connection.send(this.connectionName, this.methodName, 
					this.layout.format(event), level);
			}
			catch (error:Error)
			{
				if (LoggerManager.traceErrors)
					trace("Log5F:", error);
			}
		}
	}
}