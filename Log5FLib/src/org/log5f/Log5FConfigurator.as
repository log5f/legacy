////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import org.log5f.core.ConfigurationLoader;
	import org.log5f.core.configurators.ConfiguratorFactory;
	import org.log5f.core.configurators.IConfigurator;

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
		 * Starts configuration process, if <code>data</code> param is not 
		 * specified the configuration file will be loaded from default sources.
		 * 
		 * @param data The configuration data, can be <code>XML</code> or <code>String</code>.
		 * 
		 * @see TODO SEE MORE ABOUT DEFAULT URLs
		 */
		public static function configure(source:Object=null, force:Boolean=false):void
		{
			if (source)
			{
				var configurator:IConfigurator = 
					ConfiguratorFactory.getConfigurator(source);
				
				if (configurator)
				{
					_ready = _ready || configurator.configure(source);
					
					_traceErrors = configurator.traceErrors;
					
					LoggerManager.log5f_internal::processDeferredLogs();
					
					return;
				}
			}
			
			if (source is String)
			{
				ConfigurationLoader.log5f_internal::add(String(source));
			}
			
			if (force)
			{
				ConfigurationLoader.log5f_internal::load();
			}
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