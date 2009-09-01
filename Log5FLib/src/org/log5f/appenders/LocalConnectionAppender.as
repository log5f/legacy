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
	
	import org.log5f.Appender;
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>LocalConnectionAppender</code> appends log events over
	 * <code>LocalConnection</code> class.
	 * 
	 * @see flash.net.LocalConnection LocalConnection
	 */
	public class LocalConnectionAppender extends Appender
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * The default name of the connection that used for sending log events.
		 * 
		 * @see connectionName
		 */
		public static const DEFAULT_CONNECTION_NAME:String = "_log5f";

		/**
		 * The default name of method that received log events.
		 * 
		 * @see methodName
		 */
		public static const DEFAULT_METHOD_NAME:String = "log";
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LocalConnectionAppender()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * Using for sending log events to a some Flash based logger.
		 */
		protected var connection:LocalConnection;
		
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
		 * The name of connection that used for connecting to a destination.
		 * The default value is <i>_log5f</i>.
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
		
		//-----------------------------------
		//	methodName
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the methodName property.
		 */
		private var _methodName:String;

		/**
		 * The name of method that receives sended log events.
		 */
		public function get methodName():String
		{
			return this._methodName || DEFAULT_METHOD_NAME;
		}

		/**
		 * @private
		 */
		public function set methodName(value:String):void
		{
			if (value === this._methodName)
				return;
			
			this._methodName = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Appends log events over LocalConnection.
		 */
		override protected function append(event:LogEvent):void
		{
			if (!this.connection)
			{
				this.connection = new LocalConnection();
				
				this.connection.addEventListener(StatusEvent.STATUS, 
												 statusHandler);
					
				this.connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, 
												 asyncErrorHandler);
					
				this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
												 securityErrorHandler);
			}
			
			this.connection.send(this.connectionName, this.methodName,
								 this.layout.format(event));
		}
		
		/**
		 * Closes and removes the <code>connection</code>.
		 */
		override public function close():void
		{
			if (!this.connection)
				return;
			
			this.connection.removeEventListener(StatusEvent.STATUS, statusHandler);
				
			this.connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, 
												asyncErrorHandler);
				
			this.connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, 
												securityErrorHandler);
			
			this.connection.close();
				
			this.connection = null;
		}
		
		//----------------------------------------------------------------------
		//
		//	Event handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * Handles an <i>status</i> event of LocalConnection.
		 */
		protected function statusHandler(event:StatusEvent):void
		{
		}
		
		/**
		 * Handles an <i>asyncError</i> event of LocalConnection.
		 * 
		 * Closes local connection.
		 */
		protected function asyncErrorHandler(event:AsyncErrorEvent):void
		{
			this.close();
		}
		
		/**
		 * Handles an <i>securityError</i> event of LocalConnection.
		 * 
		 * Closes local connection.
		 */
		protected function securityErrorHandler(event:SecurityErrorEvent):void
		{
			this.close();
		}
	}
}