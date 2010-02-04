////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
{
	import org.log5f.events.LogEvent;
	
	/**
	 * Converts log event to a number of line.
	 */
	public class LineNumberConverter extends StackConverter
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
			super(StackPart.LINE_NUMBER);
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
		 * @see org.log5f.layouts.converters.IConverter#convert
		 * @see http://github.com/jonathanbranam/360flex08_presocode/ Jonathan Branams Presentation
		 */
		override public function convert(event:LogEvent):String
		{
			return super.convert(event);
		}
	}
}