////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
{
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
		 * 
		 * @param precision The number of right most components of the category
		 * name.
		 */
		public function CategoryConverter(precision:int=0)
		{
			super();
			
			this.precision = precision;
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var precision:int = 0;
		
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
		 * @see org.log5f.layouts.converters.IConverter#convert
		 */
		public function convert(event:LogEvent):String
		{
			var categoryName:String = event.category.name;
			
			return categoryName.split(".").slice(-this.precision).join(".");
		}
	}
}