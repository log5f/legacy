////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>IFormatter</code> is an interface for all formatters of the 
	 * Log5F. The filters are used to format string representation of the log
	 * message.
	 */
	public interface IFormatter
	{
		/**
		 * Formats message of the specified log event and return the same log 
		 * event, but with modified message.
		 * 
		 * @param event The log event that contains message to formatting.
		 * 
		 * @return The same log event with modified message.
		 */
		function format(event:LogEvent):LogEvent;
	}
}