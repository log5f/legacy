////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.configurators
{
	import org.log5f.core.configurators.xml.XMLConfigurator;

	/**
	 * A factory that encapsulates logic of the creating configurators.
	 */
	public class ConfiguratorFactory
	{
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * A factory method that creates a concrete configurator by type of the 
		 * specified param.
		 * 
		 * @param data The data that used to configure <code>Log5F</code>.
		 * 
		 * @return Concrete configurator for the specified data.
		 */
		public static function getConfigurator(data:Object):IConfigurator
		{
			if (data is XML)
				return new XMLConfigurator();
			
			return null;
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function ConfiguratorFactory()
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