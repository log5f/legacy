////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
{
	import org.log5f.events.LogEvent;
	
	/**
	 * Converts log event to a file's name.
	 */
	public class FileConverter extends StackConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function FileConverter()
		{
			super(StackPart.FILE_NAME);
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods: IConverter
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns the name of file where logging is used. 
		 * 
		 * This information given from the call stack. 
		 * 
		 * @param event The log event that will converted to an specified value.
		 * @param params Must be empty.
		 * 
		 * @return The name of file from call stack.
		 * 
		 * @see org.log5f.layouts.converters.StackBasedConverter#parseStack()
		 */
		override public function convert(event:LogEvent):String
		{
			return super.convert(event);
		}
	}
}