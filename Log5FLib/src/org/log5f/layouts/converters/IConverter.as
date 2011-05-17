////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
{
	import org.log5f.events.LogEvent;

	/**
	 * The interface for all converters.
	 */
	public interface IConverter
	{
		/**
		 * Converts <code>event</code> to a specified value.
		 * 
		 * @param event The log event that will converted to an specified value.
		 * 
		 * @return Result of converting of <code>event</code>.
		 */
		function convert(event:LogEvent):String;
	}
}