////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.coverters
{
	import org.log5f.IConverter;
	import org.log5f.events.LogEvent;
	
	/**
	 * Converts log event to a category name.
	 */
	public class CategoryConverter implements IConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function CategoryConverter()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods: IConverter
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns the category name of log event.
		 * 
		 * @param event The log event that will converted to an specified value.
		 * 
		 * @return The name of category.
		 * 
		 * @see org.log5f.events.LogEvent
		 * @see org.log5f.layouts.coverters.IConverter#convert
		 */
		public function convert(event:LogEvent):String
		{
			return event.category.category;
		}
	}
}