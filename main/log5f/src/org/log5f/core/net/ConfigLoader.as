////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.net
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.log5f.core.config.Config;

	//-------------------------------------
	//	Events
	//-------------------------------------
	
	/**
	 * Dispatches when loading from some request is competed.
	 * 
	 * @eventType change
	 */
	[Event(name="change",type="flash.events.Event")]
	
	/**
	 * Dispatches when loading from all requests is competed.
	 * 
	 * @eventType complete
	 */
	[Event(name="complete",type="flash.events.Event")]

	/**
	 * Dispatches when loading is caused some error.
	 * 
	 * @eventType error
	 */
	[Event(name="error",type="flash.events.ErrorEvent")]
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ExcludeClass]
	
	/**
	 * Loads documents over HTTP protocol.
	 * 
	 * @see flash.net.Loader Loader
	 */
	public class ConfigLoader extends EventDispatcher
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
		
		/**
		 * Constructor.
		 */
		public function ConfigLoader()
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
		private var loader:URLLoader;
		
		/**
		 * @private
		 */
		private var request:URLRequest;
		
		/**
		 * @private
		 */
		private var requests:Array;
		
		/**
		 * @private
		 */
		private var loading:Boolean = false;
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 * Storage for data property.
		 */
		private var _data:Object = null;
		
		/**
		 * 
		 */
		public function get data():Object
		{
			return this._data;
		}
		
		//-----------------------------------
		//	predefinedRequests
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the predefinedRequests property.
		 */
		private var _predefinedRequests:Array;

		/**
		 * The list of predefined urls.
		 */
		public function get predefinedRequests():Array
		{
			return this._predefinedRequests;
		}

		/**
		 * @private
		 */
		public function set predefinedRequests(value:Array):void
		{
			if (value === this._predefinedRequests)
				return;
			
			this._predefinedRequests = value;
			
			if (!this.requests)
				this.requests = [];
			
			for each (var request:URLRequest in this._predefinedRequests)
			{
				this.requests.push(request);
			}
		}
		
		//-----------------------------------
		//	hasSpecifiedRequest
		//-----------------------------------
		
		/**
		 * Check if some specified urls exist.
		 * 
		 * @return <code>true</code> - if specified url exists, or 
		 * <code>false</code> - otherwise.
		 */
		public function get hasSpecifiedRequest():Boolean
		{
			for each (var request:URLRequest in this.requests)
			{
				if (!this.isPredefinedRequest(request))
					return true;
			}
			
			return false;
		}

		//-----------------------------------
		//	isPredefinedRequest
		//-----------------------------------
		
		/**
		 * Check if specified <code>url</code> is default Log5F's url.
		 * 
		 * @param url The url to check.
		 * 
		 * @return <code>true</code> - if specified url is predefined, 
		 * or <code>false</code> - otherwise.
		 */
		public function isPredefinedRequest(request:URLRequest):Boolean
		{
			if (!this.predefinedRequests || this.predefinedRequests.length == 0)
				return false;
				
			return this.predefinedRequests.indexOf(request) != -1;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------

		/**
		 * Adds request to queue list
		 * 
		 * @param request The request to add.
		 */
		public function addRequest(request:URLRequest):void
		{
			if (!request || this.hasRequest(request))
				return;
			
			if (!this.requests)
				this.requests = [];
			
			this.requests.unshift(request);
		}
		
		/**
		 * Check if specified request already added.
		 * 
		 * @param request The request to check.
		 */
		public function hasRequest(request:URLRequest):Boolean
		{
			return this.requests && this.requests.indexOf(request) != -1;
		}
		
		/**
		 * Loads data from specified requests.
		 */
		public function load():void
		{
			if (this.loading)
				return;
			
			this.request = this.requests.shift();
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			loader.load(this.request);
			
			this.loading = true;
		}
		
		//----------------------------------------------------------------------
		//
		//	Event handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * The handler of "complete" event of <code>loader</code>.
		 *
		 * Initiates configuration of Log5F if loaded configuration file is XML.
		 *
		 * @param event The event.
		 */
		protected function loaderCompleteHandler(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			this.loading = false;
			this.request = null;
			
			this._data = URLLoader(event.target).data;
			
			this.dispatchEvent(new Event(Event.CHANGE));
			
			if (this.hasSpecifiedRequest)
			{
				this.load();
			}
			else
			{
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		/**
		 * The handler of "ioError" event of <code>loader</code>.
		 *
		 * @param event The Input/Output Error event.
		 */
		protected function loaderIOErrorHandler(event:IOErrorEvent):void
		{
			event.target.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			if (!this.isPredefinedRequest(this.request))
			{
				if (Config.traceErrors)
					trace("Log5F:", event.text);
			}
			
			this.loading = false;
			this.request = null;
			
			if (this.requests && this.requests.length > 0)
			{
				this.load();
			}
			else 
			{
				this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.text));
			}
		}
		
		/**
		 * The handler of <i>securityError</i> event of <code>loader</code>.
		 *
		 * @param event The Security Error event.
		 */
		protected function loaderSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			event.target.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			this.loading = false;
			this.request = null;
			
			this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.text));
		}
	}
}