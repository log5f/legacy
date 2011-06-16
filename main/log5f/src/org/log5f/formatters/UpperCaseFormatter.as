////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.formatters
{
	import org.log5f.core.IFormatter;
	import org.log5f.events.LogEvent;

	/**
	 * Converts all the string character of the <code>LogEvent.message</code> 
	 * into uppercase letters.
	 */
	public class UpperCaseFormatter implements IFormatter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function UpperCaseFormatter()
		{
			super();
		}

		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/** @inheritDoc */
		public function format(event:LogEvent):LogEvent
		{
//			if (event.message)
//				event.message = event.message.toString().toUpperCase();
			
			return event;
		}
	}
}