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
			
			var isDefaultOrNull:Boolean = 
				!name || name == LocalConnectionAppender.DEFAULT_CONNECTION_NAME;
			
			return isDefaultOrNull ? DEFAULT_CONNECTION_NAME : name;
		}

		//-----------------------------------
		//	methodName
		//-----------------------------------

		/** @inheritDoc */
		override public function get methodName():String
		{
			var name:String = super.methodName;
			
			var isDefaultOrNull:Boolean = 
				!name || name == LocalConnectionAppender.DEFAULT_METHOD_NAME;
			
			return isDefaultOrNull ? DEFAULT_METHOD_NAME : name;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overriden methods
		//
		//----------------------------------------------------------------------

		/** @inheritDoc */
		override protected function getParameters(event:LogEvent):Array
		{
			var level:int;
			
			switch (event.level.toInt())
			{
				case Level.ALL.toInt():
				
					level = 0x00;
					
					break;
					
				case Level.DEBUG.toInt():
				
					level = 0x01;
					
					break;
					
				case Level.INFO.toInt():
				
					level = 0x02;
					
					break;
					
				case Level.WARN.toInt():
				
					level = 0x04;
					
					break;
					
				case Level.ERROR.toInt():
				
					level = 0x08;
					
					break;
					
				case Level.FATAL.toInt():
				
					level = 0x08;
					
					break;
					
				case Level.OFF.toInt():
				
					level = 0xFF;
					
					break;
			}
			
			return [getTimer(), this.layout.format(event), level];
		}
	}
}