////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import org.log5f.events.LogEvent;

	/**
	 * The <code>ILayout</code> is an interface that each layout must implement.
	 * The layouts are used for transforming <conde>LogEvent</conde> instances
	 * into form, that is appropriate for the concrete logging target.
	 */
	public interface ILayout
	{
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * A flag that indicates if concrete layout needs information from the 
		 * stack.
		 */
		function get isStackNeeded():Boolean;
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Converts log event to string representation.
		 * 
		 * @param event The log event that will be converted to string 
		 * representation. 
		 * 
		 * @return The simple representation of the specified log event. 
		 */
		function format(event:LogEvent):String;
	}
}