////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import org.log5f.core.ConfigurationLoader;
	import org.log5f.core.configurators.ConfiguratorFactory;
	import org.log5f.core.configurators.IConfigurator;
	import org.log5f.core.managers.DeferredManager;

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
		
		//----------------------------------------------------------------------
		//
		//	Class properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	ready
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the ready property.
		 */
		private static var _ready:Boolean = false;

		/**
		 * Indicates if Log5F is ready to use.
		 * 
		 * @default false;
		 */
		public static function get ready():Boolean
		{
			return _ready;
		}

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
		 * @param force Inidicates if need to start loading XML data from 
		 * specified url in <code>source</code> at once.
		 * 
		 * @see TODO SEE MORE ABOUT DEFAULT URLs
		 */
		public static function configure(source:Object, force:Boolean=false):void
		{
			var configurator:IConfigurator = 
				ConfiguratorFactory.getConfigurator(source);
			
			if (configurator)
			{
				_ready = _ready || configurator.configure(source);
				
				_traceErrors = _traceErrors ? configurator.traceErrors : false;
				
				DeferredManager.log5f_internal::processLogs();
				
				return;
			}
			else if (source is String)
			{
				ConfigurationLoader.log5f_internal::add(String(source));
			}
			
			if (force)
			{
				log5f_internal::configure();
			}
		}
		
		/**
		 * The internal method that starts loading configuration files.
		 */
		log5f_internal static function configure():void
		{
			ConfigurationLoader.log5f_internal::load();
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function Log5FConfigurator()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
	}
}