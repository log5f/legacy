////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
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
		
		/**
		 * Stores all log events between sending.
		 */
		private var buffer:String = "";
		
		/**
		 * Stores id of interval that used for sending data.
		 */
		private var intervalID:Number = NaN;
		
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
		
		//-----------------------------------
		//	interval
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the interval property.
		 */
		private var _interval:int = 0;

		/**
		 * The number in milliseconds between sending log event to server.
		 * 
		 * <b>Note</b>: If 0 interval don't uses.
		 */
		public function get interval():int
		{
			return this._interval;
		}

		/**
		 * @private
		 */
		public function set interval(value:int):void
		{
			this._interval = value;
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

				this.socket.addEventListener(Event.CLOSE, closeHandler);
				
				this.socket.addEventListener(Event.CONNECT, connectHandler);
				
				this.socket.addEventListener(IOErrorEvent.IO_ERROR, 
											 ioErrorHandler);
				
				this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
											 securityErrorHandler);
				
				this.buffer = this.layout.format(event);
			}
			else if (this.interval == 0)
			{
				this.socket.send(this.layout.format(event));
			}
			else
			{
				this.buffer += this.layout.format(event);
			}
		}
		
		/**
		 * @inheritDoc
		 * 
		 * Closes the <code>socket</code>.
		 */
		override public function close():void
		{
			if (!this.socket)
				return;
			
			this.socket.removeEventListener(Event.CLOSE, closeHandler);
				
			this.socket.removeEventListener(Event.CONNECT, connectHandler);
				
			this.socket.removeEventListener(IOErrorEvent.IO_ERROR, 
											ioErrorHandler);
			
			this.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,
											securityErrorHandler);
			
			if (this.socket.connected)
				this.socket.close();
			
			if (!isNaN(this.intervalID))
				clearInterval(this.intervalID);
		}
		
		/**
		 * Sends data from buffer to a opened socket.
		 */
		private function send():void
		{
			if (this.buffer == "")
				return;
			
			this.socket.send(this.buffer);
			
			this.buffer = "";
		}
		
		//----------------------------------------------------------------------
		//
		//	Event handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * Handles an <i>connect</i> event of XMLSocket.
		 */
		private function connectHandler(event:Event):void
		{
			if (this.interval > 0)
				setInterval(this.send, this.interval);
			
			this.send();
		}
		
		/**
		 * Handles an <i>close</i> event of XMLSocket.
		 * 
		 * Closes socket connection.
		 */
		private function closeHandler(event:Event):void
		{
			this.close();
		}
		
		/**
		 * Handles an <i>input/output error</i> event of XMLSocket.
		 */
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			this.close();
		}
		
		/**
		 * Handles an <i>security error</i> event of XMLSocket.
		 */
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			this.close();
		}
	}
}