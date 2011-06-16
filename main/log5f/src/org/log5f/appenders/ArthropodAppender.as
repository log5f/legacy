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
	
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>ArthropodAppender</code> appends log events to the Arthropod
	 * 
	 * @see http://arthropod.stopp.se/ Arthropod
	 */
	public class ArthropodAppender extends LocalConnectionAppender
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * The default value of the <code>password</code>.
		 * 
		 * @see password
		 */
		public static const DEFAULT_PASSWORD:String = "CDC309AF";
		
		/**
		 * The default name of the connection that used for sending log events.
		 * 
		 * @see connectionName
		 */
		public static const DEFAULT_CONNECTION_NAME:String = 
			"app#com.carlcalderon.Arthropod.161E714B6C1A76DE7B9865F88B32FCCE8FABA7B5.1:arthropod";
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ArthropodAppender()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden properties
		//
		//----------------------------------------------------------------------
		
		override public function get connectionName():String
		{
			return super.connectionName == LocalConnectionAppender.DEFAULT_CONNECTION_NAME ?
				   ArthropodAppender.DEFAULT_CONNECTION_NAME : 
				   super.connectionName;
		}
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	password
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the password property.
		 */
		private var _password:String;

		/**
		 * The password for conecting to an Arthropod. See Arthropod -> 
		 * Settings -> Connection Password
		 */
		public function get password():String
		{
			return this._password || DEFAULT_PASSWORD;
		}

		/**
		 * @private
		 */
		public function set password(value:String):void
		{
			if (value === this._password)
				return;
			
			this._password = value;
		}

		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * 
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
												 
				this.connection.allowInsecureDomain("*");
			}
			
			var color:uint;
			var methodName:String;
			
			switch (event.level.toInt())
			{
				case Level.ALL.toInt():
				{
					color = 0xFEFEFE;
					methodName = "debug";
					
					break;
				}
				
				case Level.DEBUG.toInt():
				{
					color = 0xFEFEFE;
					methodName = "debug";
					
					break;
				}
				
				case Level.INFO.toInt():
				{
					color = 0xFEFEFE;
					methodName = "debug";
					
					break;
				}
				
				case Level.WARN.toInt():
				{
					color = 0xCCCC00;
					methodName = "debugWarning";
					
					break;
				}
				
				case Level.ERROR.toInt():
				{
					color = 0xCC0000;
					methodName = "debugError";
					
					break;
				}

				case Level.FATAL.toInt():
				{
					color = 0xCC0000;
					methodName = "debugError";
					
					break;
				}

				case Level.OFF.toInt():
				{
					color = 0x000000;
					methodName = "debugClear";
					
					break;
				}
			}
			
			try
			{
				this.connection.send(this.connectionName, methodName, 
									 this.password, this.layout.format(event),
									 color);
			}
			catch (error:Error)
			{
				trace(error);
			}
		}
	}
}