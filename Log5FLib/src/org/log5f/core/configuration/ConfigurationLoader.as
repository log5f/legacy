////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.configuration
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.core.Singleton;
	
	import org.log5f.core.configuration.XMLConfiguratorImpl;
	import org.log5f.error.AppenderNotFoundError;
	import org.log5f.error.CallAbstractMethodError;
	import org.log5f.error.ClassNotFoundError;
	import org.log5f.error.DocumentInvalidError;
	import org.log5f.error.FileNotFoundError;
	import org.log5f.error.IllegalArgumentError;
	import org.log5f.error.InvalidAppenderError;
	import org.log5f.error.InvalidConfigError;
	import org.log5f.error.SingletonError;
	import org.log5f.helpers.resources.ResourceManager;
	import org.log5f.utils.FlashvarsUtils;
	
	[ExcludeClass]
	
	/**
	 * Loads configuration file.
	 */
	public class ConfigurationLoader
	{
		//----------------------------------------------------------------------
		//
		//	Class constatns
		//
		//----------------------------------------------------------------------
		
		/**
		 * The name of configuration file.
		 */
		public static const FILE:String = "log5f.properties";
		
		/**
		 * Defines the queue of configuration files. 
		 */
		private static const FILES:Array = 
			[
				"log5f.xml",
				"log5f.properties",
			]
		
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * The request of configuration file that used by <code>loader</code>.
		 */
		private static var request:URLRequest = new URLRequest();
		
		/**
		 * The loader that loads configuration file.
		 */
		private static var loader:URLLoader = new URLLoader();
		
		/**
		 * The flag that indicates if configuration file is loading.
		 */
		private static var isLoading:Boolean = false;
		
		//----------------------------------------------------------------------
		//
		//	Class properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	url
		//-----------------------------------
		
		/**
		 * @private
		 */
		private static var _url:String = null;
		
		/**
		 * Raw data of the configuration.
		 */
		public static function get url():String
		{
			return _url;
		}
		
		//-----------------------------------
		//	data
		//-----------------------------------
		
		/**
		 * @private
		 */
		private static var _data:Object = null;
		
		/**
		 * Raw data of the configuration.
		 */
		public static function get data():Object
		{
			return _data;
		}
		
		//-----------------------------------
		//	isLoaded
		//-----------------------------------
		
		/**
		 * @private
		 */
		private static var _isLoaded:Boolean = false;
		
		/**
		 * Flag that indicates if configuration file is loaded.
		 */
		public static function get isLoaded():Boolean
		{
			return _isLoaded;
		}
		
		//-----------------------------------
		//	status
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for <code>status</code> property.
		 */
		private static var _status:String = ConfigurationLoaderStatus.READY;
		
		/**
		 * Indicates the current status of loader. 
		 * <p>Can takes one from next values:</p>
		 * 
		 * <ul>
		 * 	<li><i>ready</i> - to indicate that loader is ready to start load config file;</li> 
		 * 	<li><i>loading</i> - to indicate that config file is loading now;</li> 
		 * 	<li><i>success</i> - to indicate that config loaded successful;</li>
		 * 	<li><i>failure</i> - to indicate that config doesn't exist;</li>
		 * </ul>
		 * 
		 * @default ready
		 * 
		 * @see ConfigurationLoaderStatus
		 */
		public static function get status():String
		{
			return _status;
		}
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Loads configuration file, if it is not loaded.
		 */
		public static function load():void
		{
			if (status == ConfigurationLoaderStatus.READY)
			{
				if (FILES.length > 0)
				{
					loadInternal(FILES.shift());
					
					_status = ConfigurationLoaderStatus.LOADING;
				}
				else
				{
					_status = ConfigurationLoaderStatus.FAILURE;
				}
			}
		}
		
		/**
		 * @private
		 */
		private static function loadInternal(url:String):void
		{
			_url = url;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			loader.load(new URLRequest(url));
		}
		
		//----------------------------------------------------------------------
		//
		//	Class event handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * The handler of "complete" event of <code>loader</code>.
		 *
		 * Initiates configuration of Log5F if loaded configuration file is XML.
		 *
		 * @param event The event.
		 */
		protected static function loaderCompleteHandler(event:Event):void
		{
			isLoading = false;
			
			event.target.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			_status = ConfigurationLoaderStatus.SUCCESS;
			
			_data = new XML(URLLoader(event.target).data);
			
			Singleton.registerClass("org.log5f.core.IConfigurator", 
				XMLConfiguratorImpl);
			
			Configurator.configure();
		}
		
		/**
		 * The handler of "ioError" event of <code>loader</code>.
		 *
		 * Sets <code>status</code> to <code>failure</code> if not many files to
		 * load, or <code>redy</code> - otherwise.
		 *
		 * @param event The Input/Output Error event.
		 */
		protected static function loaderIOErrorHandler(event:IOErrorEvent):void
		{
			event.target.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			if (FILES.length == 0)
			{
				_status = ConfigurationLoaderStatus.FAILURE;
				
				if (Configurator.traceErrors)
					trace("Log5F:", event.text);
			}
			else
			{
				_status = ConfigurationLoaderStatus.READY;
				
				load();
			}
		}
		
		/**
		 * The handler of <i>securityError</i> event of <code>loader</code>.
		 *
		 * Sets <code>status</code> to <code>failure</code>.
		 *
		 * @param event The Security Error event.
		 */
		protected static function loaderSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			event.target.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			_status = ConfigurationLoaderStatus.FAILURE;
			
			if (Configurator.traceErrors)
				trace("Log5F:", event.text);
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ConfigurationLoader()
		{
			super();
		}
	}
}