////////////////////////////////////////////////////////////////////////////////
// Copyright 2007, Transparent Language, Inc..
// All Rights Reserved.
// Transparent Language Confidential Information
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
		public static function configure(source:Object=null):void
		{
			if (source)
			{
				var configurator:IConfigurator = 
					ConfiguratorFactory.getConfigurator(source);
				
				if (configurator)
				{
					configurator.configure(source);
					
					_ready = true;
					
					LoggerManager.log5f_internal::processDeferredLogs();
					
					return;
				}
			}
			
			ConfigurationLoader.load(source as String);
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