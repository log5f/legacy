////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.configurators
{
	import flash.events.IEventDispatcher;

	/**
	 * Interface for configurators.
	 */
	public interface IConfigurator extends IEventDispatcher
	{
		/**
		 * Flag that indicates if Log5F is configured.
		 */
		function get isConfigured():Boolean; 
		
		/**
		 * A flag that indicates need to trace error messages.
		 */
		function get traceErrors():Boolean;
			
		/**
		 * Configures Log5F.
		 * 
		 * @param source Configuration of Log5F in raw data. 
		 */
		function configure(source:Object):void;
	}
}