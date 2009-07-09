////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	
	import org.log5f.Appender;
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>XMLSocketAppender</code> appends log events to the 
	 * specified xml socket.
	 * 
	 * This appender can be used for appending log to a Chainsaw
	 * 
	 * @see http://logging.apache.org/chainsaw/ Chainsaw
	 */
	public class XMLSocketAppender extends Appender
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * The default host for XMLSocket.
		 */
		public static const DEFAULT_HOST:String = "localhost";

		/**
		 * The default port for XMLSocket.
		 */
		public static const DEFAULT_PORT:Number = 4445;
		
		/**
		 * 
		 */
		public static const DEFAULT_INTERVAL:int = 200;
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/**
		 * Constructor.
		 */
		public function XMLSocketAppender()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * The socket that used for sending lg events.
		 */
		private var socket:XMLSocket;

		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	host
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the host property.
		 */
		private var _host:String;

		/**
		 * The host of XMLSocket.
		 */
		public function get host():String
		{
			return this._host || XMLSocketAppender.DEFAULT_HOST;
		}

		/**
		 * @private
		 */
		public function set host(value:String):void
		{
			if (value === this._host)
				return;
			
			this._host = value;
		}
		
		//-----------------------------------
		//	port
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the port property.
		 */
		private var _port:int;

		/**
		 * The port of XMLSocket.
		 */
		public function get port():int
		{
			return this._port || XMLSocketAppender.DEFAULT_PORT;
		}

		/**
		 * @private
		 */
		public function set port(value:int):void
		{
			if (value === this._port)
				return;
			
			this._port = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overriden methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Appends log events to a specified socket.
		 */
		override protected function append(event:LogEvent):void
		{
			if (!this.socket)
			{
				this.socket = new XMLSocket(this.host, this.port);
				
				this.socket.addEventListener(IOErrorEvent.IO_ERROR, 
											 ioErrorHandler);
				
				this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
											 securityErrorHandler);
			}
			
			trace(this.layout.format(event));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function close():void
		{
			if (!this.socket)
				return;
			
			this.socket.removeEventListener(IOErrorEvent.IO_ERROR, 
											ioErrorHandler);
			
			this.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,
											securityErrorHandler);
		}
		
		//----------------------------------------------------------------------
		//
		//	Event handlers
		//
		//----------------------------------------------------------------------
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			
		}
		
	}
}