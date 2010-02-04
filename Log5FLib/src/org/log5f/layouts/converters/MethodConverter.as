////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
{
	import org.log5f.events.LogEvent;
	
	/**
	 * Converts log event to a name of method.
	 */
	public class MethodConverter extends StackConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function MethodConverter()
		{
			super(StackPart.METHOD_NAME);
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods: IConverter	
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns the name of method where log method is called. 
		 * 
		 * This information given from the call stack. 
		 * This method based on Jonathan Branams regular expression.
		 * 
		 * @param event The log event that will converted to an specified value.
		 * 
		 * @return The name of method from call stack.
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