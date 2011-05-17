////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.log5f.core.config.configurators.ConfiguratorFactory;
	import org.log5f.core.config.configurators.IConfigurator;
	import org.log5f.core.managers.DeferredManager;
	import org.log5f.core.net.ConfigLoader;
	import org.log5f.utils.LoaderInfoUtil;

	/**
	 * Configures the Log5F.
	 */
	public class Log5FConfigurator
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * Defines the queue of configuration files. 
		 */
		private static const PREDEFINED_REQUESTS:Array = 
			[
				new URLRequest("log5f.xml"),
				new URLRequest("log5f.properties"),
			];
		
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static var ready:Boolean = false;
		
		/**
		 * @private
		 */
		private static var loader:ConfigLoader;
		
		/**
		 * @private
		 */
		private static var initialized:Boolean = init();
		
		//----------------------------------------------------------------------
		//
		//	Class properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	traceErrors
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the traceErrors property.
		 */
		private static var _traceErrors:Boolean = true;

		/**
		 * A flag that indicates need to trace error messages.
		 * 
		 * <p>By default error tracing enabled, it can be disabled from 
		 * configuration.</p>
		 * 
		 * <p><b>Note</b>: This feature con't be enabled from configuration.
		 * If you can two configuration first that disables traceErrors and 
		 * second that allows traceErrors the allowing from the second 
		 * will ignored. Only way to enable this feauter - not disable it.</p> 
		 * 
		 * @default true
		 */
		public static function get traceErrors():Boolean
		{
			return _traceErrors;
		}

		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * This is a external method, it can be used to configure Log5F in 
		 * runtime.
		 * 
		 * @param source Contains a configuration data, can be <code>XML</code> 
		 * or <code>String</code>. If it is a <code>XML</code> it will used for
		 * configuration immediately, if it is a <code>String</code> it will 
		 * used as an url to load configuration data.
		 * 
		 * @see TODO SEE MORE ABOUT DEFAULT URLs
		 */
		public static function configure(source:Object):void
		{
			var configurator:IConfigurator = 
				ConfiguratorFactory.getConfigurator(source);
			
			if (configurator)
			{
				ready = ready || configurator.configure(source);
				
				_traceErrors = _traceErrors ? configurator.traceErrors : false;
				
				return;
			}
			
			source = source is String ? new URLRequest(String(source)) : source;
			
			if (source is URLRequest)
			{
				if (!loader)
				{
					loader = new ConfigLoader();
					loader.addEventListener(Event.CHANGE, loader_changeHandler);
					loader.addEventListener(Event.COMPLETE, loader_completeHandler);
					loader.addEventListener(ErrorEvent.ERROR, loader_errorHandler);
				}
				
				loader.addRequest(URLRequest(source));
			}
		}

		/**
		 * Indicates if Log5FConfigurator is needed for update
		 */
		log5f_internal static function get needUpdate():Boolean
		{
			return (loader && loader.hasSpecifiedRequest) || !ready;
		}
		
		/**
		 * The internal method that starts loading configuration files.
		 */
		log5f_internal static function update():void
		{
			if (loader)
				loader.load();
			else
				changeEnabled();
		}
		
		/**
		 * @private
		 */
		private static function init():Boolean
		{
			loader = new ConfigLoader();
			loader.addEventListener(Event.CHANGE, loader_changeHandler);
			loader.addEventListener(Event.COMPLETE, loader_completeHandler);
			loader.addEventListener(ErrorEvent.ERROR, loader_errorHandler);
			
			loader.predefinedRequests = PREDEFINED_REQUESTS;
			
			var params:Object = LoaderInfoUtil.getParameters();
			
			if (params && params["log5f"])
			{
				loader.addRequest(new URLRequest(params["log5f"]));
			}
			
			return true;
		}
		
		/**
		 * @private
		 */
		private static function changeEnabled():void
		{
			LoggerManager.log5f_internal::enabled = ready;
			
			if (ready)
			{
				DeferredManager.log5f_internal::processLogs();
			}
			else
			{
				DeferredManager.log5f_internal::removeLogs();
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	Class event handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static function loader_completeHandler(event:Event):void
		{
			if (loader)
			{
				loader.removeEventListener(Event.CHANGE, loader_changeHandler);
				loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
				loader.removeEventListener(ErrorEvent.ERROR, loader_errorHandler);
				
				loader = null;
			}
			
			changeEnabled();
		}
		
		/**
		 * @private
		 */
		private static function loader_changeHandler(event:Event):void
		{
			if (loader)
			{
				Log5FConfigurator.configure(loader.data);
			}
		}
		
		/**
		 * @private
		 */
		private static function loader_errorHandler(event:ErrorEvent):void
		{
			if (loader)
			{
				loader.removeEventListener(Event.CHANGE, loader_changeHandler);
				loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
				loader.removeEventListener(ErrorEvent.ERROR, loader_errorHandler);
				
				loader = null;
			}
			
			if (traceErrors)
				trace("Log5F:", event.text);
			
			changeEnabled();
		}
	}
}