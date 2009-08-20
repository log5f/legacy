////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.coverters
{
	import org.log5f.events.LogEvent;

	/**
	 * Converts log event to a name of class.
	 */
	public class ClassConverter extends StackConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ClassConverter(precision:int)
		{
			super(StackPart.CLASS_NAME);
			
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
		 * Returns the name of class where logging is used. 
		 */
		override public function convert(event:LogEvent):String
		{
			var className:String = super.convert(event);
			
			var end:int = className.length - 1;
			
			for (var i:int = this.precision; i > 0; i--)
			{
				end = className.lastIndexOf(".", end - 1);
				
				if (end == -1)
					return className;
			}
			
			return className.substring(end + 1, className.length);
		}
	}
}