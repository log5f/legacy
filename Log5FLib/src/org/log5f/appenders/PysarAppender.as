////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import org.log5f.core.Appender;
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>PysarAppender</code> appends log events to the
	 * Pysar's console.
	 *
	 * @see http://log5f.wordpress.com/appenders/
	 */
	public class PysarAppender extends Appender
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * 
		 */
		public static const DEFAULT_CONNECTION_NAME:String = "_PysarDefaultConnection";
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/**
		 * Constructor.
		 */
		public function PysarAppender()
		{
			super();
		}

		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		private var connection:LocalConnection;

		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------

		//-----------------------------------
		//	connectionName
		//-----------------------------------

		/**
		 * @private
		 * Storage for the connectionName property.
		 */
		private var _connectionName:String;

		/**
		 * The name that used for connection.
		 */
		public function get connectionName():String
		{
			return this._connectionName || DEFAULT_CONNECTION_NAME;
		}

		/**
		 * @private
		 */
		public function set connectionName(value:String):void
		{
			if (value === this._connectionName)
				return;

			this._connectionName = value;
		}

		//----------------------------------------------------------------------
		//
		//	Overriden methods
		//
		//----------------------------------------------------------------------

		/**
		 * Appends log events to <code>Pysar</code> by LocalConnection.
		 */
		override protected function append(event:LogEvent):void
		{
			if (!this.connection)
			{
				this.connection = new LocalConnection();
				
				this.connection.
					addEventListener(StatusEvent.STATUS, statusHandler);
					
				this.connection.
					addEventListener(AsyncErrorEvent.ASYNC_ERROR, 
									 asyncErrorHandler);
					
				this.connection.
					addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
									 securityErrorHandler);
			}
			
			this.connection.send(this.connectionName, "log", event);
		}
		
		/**
		 * Closes and removes the <code>connection</code>.
		 */
		override public function close():void
		{
			if (this.connection)
			{
				this.connection.close();
				
				this.connection.
					removeEventListener(StatusEvent.STATUS, statusHandler);
					
				this.connection.
					removeEventListener(AsyncErrorEvent.ASYNC_ERROR, 
										asyncErrorHandler);
					
				this.connection.
					removeEventListener(SecurityErrorEvent.SECURITY_ERROR, 
										securityErrorHandler);
			}
				
			this.connection = null;
		}
		
		//----------------------------------------------------------------------
		//
		//	Event handlers
		//
		//----------------------------------------------------------------------
		
		private function statusHandler(event:StatusEvent):void
		{
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void
		{
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
		}
	}
}