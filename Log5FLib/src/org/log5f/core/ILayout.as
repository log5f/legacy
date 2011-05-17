////////////////////////////////////////////////////////////////////////////////
// Copyright 2011, Transparent Language, Inc..
// All Rights Reserved.
// Transparent Language Confidential Information
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import org.log5f.events.LogEvent;

	/**
	 * The ILayout interface defines methods 
	 * 
	 * Layouts are used to transform log events into form, that is appropriate 
	 * for end logging tool.
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