////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
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
		 * 
		 * @param precision The number of right most components of the full 
		 * class name.
		 */
		public function ClassConverter(precision:int=0)
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
			if (!event.stack || event.stack == "")
				return "";
			
			if (this.precision == 1)
				return super.convert(event);
				
			var className:String = super.convert(event);
			
			var packageName:String = 
				new StackConverter(StackPart.PACKAGE_NAME).convert(event);
			
			var fullClassName:String = packageName + "." + className;
			
			return fullClassName.split(".").slice(-this.precision).join(".");
		}
	}
}