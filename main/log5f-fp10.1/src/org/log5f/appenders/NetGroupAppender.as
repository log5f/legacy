////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2011 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	
	import org.log5f.core.Appender;
	import org.log5f.events.LogEvent;
	
	/**
	 * The NetGroupAppender appender deliveries log information to output 
	 * target using NetGroup class.
	 */
	public class NetGroupAppender extends Appender
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/** Constructor. */
		public function NetGroupAppender()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variable
		//
		//----------------------------------------------------------------------
		
		/**  */
		private var conn:NetConnection;
		
		/**  */
		private var group:NetGroup;
		
		/** @private */
		private var connDest:String;
		
		/** @private */
		private var groupName:String;
		
		/** @private */
		private var buffer:Array;
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	destination
		//-----------------------------------
		
		/** @private */
		private var _destination:String = null;
		
		/** 
		 * The full destination path, that consists of:
		 * <br />
		 * <ul>
		 *  <li><code>SERVER-ADDRESS</code> - required, server address with protocol and 
		 * port, e.g. for Adobe Cirrus is "rtmfp://p2p.rtmfp.net/";</li>
		 *  <li><code>DEVELOPER-KEY</code> - optional, usualy your personal Adobe Cirrus 
		 * beta developer key;</li>
		 *  <li><code>GROUP-NAME</code> - requred, NetGroup name.</li>
		 * </ul>
		 * <br />
		 * in the following order:
		 * <br />
		 * SERVER-ADDRESS/DEVELOPER-KEY/GROUP-NAME
		 *
		 * <p> 
		 * Examples:
		 * <br />
		 * <code>rtmfp://p2p.rtmfp.net/{DEVELOPER-KEY}/my-iphone-app</code>
		 * <br />
		 * <code>rtmfp://my-own-p2p-server.com/my-app</code>
		 * </p>
		 */
		public function get uri():String
		{
			return this._destination;
		}
		
		/** @private */
		public function set uri(value:String):void
		{
			this._destination = value;
			
			this.retrieveDestinationParts();
		}
		
		//-----------------------------------
		//	isConnected
		//-----------------------------------
		
		/** Indicates if NetGroup connected */
		protected function get isConnected():Boolean
		{
			return this.conn && this.conn.connected && this.group;
		}
		
		//-----------------------------------
		//	isConnected
		//-----------------------------------
		
		/** Check if current destination is valid */
		protected function get isDestinationValid():Boolean
		{
			const pattern:RegExp = /^rtmfp:\/\//;
			
			return pattern.test(this.uri);
		}
		
		//----------------------------------------------------------------------
		//
		//	Overriden methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Sends log entry over NetGroup to remote Output Target. 
		 */
		override protected function append(event:LogEvent):void
		{
			if (!this.buffer)
				this.buffer = [];
			
			this.buffer.push(this.layout.format(event));
			
			if (this.isConnected)
			{
				this.post();
			}
			else
			{
				this.connect();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function close():void
		{
			if (this.group)
			{
				this.group.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				this.group.close();
				this.group = null;
			}
			
			if (this.conn)
			{
				this.conn.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				this.conn.removeEventListener(IOErrorEvent.IO_ERROR, conn_ioErrorHandler);
				this.conn.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, conn_asyncErrorHandler);
				this.conn.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, conn_securityErrorHandler);
				this.conn.close();
				this.conn = null;
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**  */
		protected function post():void
		{
			if (!this.group || this.buffer) 
				return;
			
			while (this.buffer.length > 0)
			{
				this.group.post(this.buffer.pop());
			}
			
			this.buffer = null;
		}
		
		/** @private */
		private function connect():void
		{
			if (this.isConnected) return;
			
			if (!this.conn)
			{
				this.conn = new NetConnection();
				this.conn.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				this.conn.addEventListener(IOErrorEvent.IO_ERROR, conn_ioErrorHandler);
				this.conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, conn_asyncErrorHandler);
				this.conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, conn_securityErrorHandler);
				
				this.conn.connect(this.connDest);
			}
			else if (!this.group && this.conn.connected)
			{
				const spec:GroupSpecifier = new GroupSpecifier(this.groupName);
				spec.postingEnabled = true;
				
				this.group = new NetGroup(this.conn, spec.groupspecWithoutAuthorizations());
				this.group.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			}
		}
		
		/** @private */
		private function retrieveDestinationParts():void
		{
			if (this.uri) 
			{
				const slash:int = this.uri.lastIndexOf("/");
				
				this.connDest = this.uri.substring(0, slash);
				this.groupName = this.uri.substring(slash + 1);
			}
			else
			{
				this.connDest = null;
				this.groupName = null;
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	Handlers
		//
		//----------------------------------------------------------------------
		
		/** @private */
		private function netStatusHandler(event:NetStatusEvent):void
		{
			trace(event.info.code);
			
			switch (event.info.code)
			{
				// NetConnection
				
				case "NetConnection.Connect.Success" :
					
					this.connect();
					
					break;

				// NetGroup
				
				case "NetGroup.Connect.Succcess" :
					
					this.post();
					
					break;
			}
		}
		
		//-----------------------------------
		//	Handlers: NetConnection
		//-----------------------------------
		
		/** @private */
		private function conn_asyncErrorHandler(event:AsyncErrorEvent):void
		{
			this.close();
		}
		
		/** @private */
		private function conn_ioErrorHandler(event:IOErrorEvent):void
		{
			this.close();
		}
		
		/** @private */
		private function conn_securityErrorHandler(event:SecurityErrorEvent):void
		{
			this.close();
		}
		
	}
}