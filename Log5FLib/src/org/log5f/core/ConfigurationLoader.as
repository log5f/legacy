////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.core.Singleton;
	
	import org.log5f.core.configurators.xml.XMLConfigurator;
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
	import org.log5f.Log5FConfigurator;
	import org.log5f.core.configuration.Configurator;
	
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
			];
		
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
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
		public static function load(url:String=null):void
		{
			if (url)
			{
				FILES.push(url);
			}
			
			if (status == ConfigurationLoaderStatus.READY)
			{
				if (FILES && FILES.length > 0)
				{
					loadReal(FILES.shift());
				}
			}
		}
		
		/**
		 * @private
		 */
		private static function loadReal(url:String):void
		{
			_url = url;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			loader.load(new URLRequest(url));
			
			_status = ConfigurationLoaderStatus.LOADING;
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
			event.target.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			_status = ConfigurationLoaderStatus.READY;
			
			_data = new XML(URLLoader(event.target).data);
			
			Log5FConfigurator.configure(data);
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
			
			_status = ConfigurationLoaderStatus.READY;
			
			if (!FILES || FILES.length == 0)
			{
				if (Configurator.traceErrors)
					trace("Log5F:", event.text);
			}
			else
			{
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
			
			_status = ConfigurationLoaderStatus.READY;
			
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