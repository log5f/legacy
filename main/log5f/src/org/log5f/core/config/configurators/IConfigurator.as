////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.configurators
{
	import flash.events.IEventDispatcher;

	/**
	 * Interface for configurators.
	 */
	public interface IConfigurator 
	{
		/**
		 * A flag that indicates need to trace error messages.
		 */
		function get traceErrors():Boolean;
			
		/**
		 * Configures Log5F.
		 * 
		 * @param source Configuration of Log5F in raw data. 
		 */
		function configure(source:Object):Boolean;
	}
}