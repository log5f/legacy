////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.coverters
{
	import org.log5f.IConverter;
	import org.log5f.events.LogEvent;
	
	/**
	 * Converts log event to a number of line.
	 */
	public class LineNumberConverter implements IConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LineNumberConverter()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods: IConverter
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns the number of line where log method is called. 
		 * 
		 * This information given from the call stack. 
		 * This method based on Jonathan Branams regular expression.
		 * 
		 * @param event The log event that will converted to an specified value.
		 * 
		 * @return The line number from call stack.
		 * 
		 * @see org.log5f.events.LogEvent
		 * @see org.log5f.layouts.coverters.IConverter#convert
		 * @see http://github.com/jonathanbranam/360flex08_presocode/ Jonathan Branams Presentation
		 */
		public function convert(event:LogEvent):String
		{
			if (!event.stack || event.stack == "")
				return "";

			var pattern:RegExp = /\tat (?:(.+)::)?(.+)\/(.+)\(\)\[(?:(.+)\:(\d+))?\]$/;
			
			var stack:Array = event.stack.split("\n");
			
			return stack[2].match(pattern)[5];
		}
	}
}