////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
{
	import org.log5f.events.LogEvent;
	import org.log5f.helpers.formatters.DateFormatter;
	
	/**
	 * Converter for date.
	 */
	public class DateConverter implements IConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param format The mask pattern that used for formatting date.
		 * 
		 * @see mx.formatters.DateFormatter#formatString
		 */
		public function DateConverter(format:String)
		{
			super();
			
			this.format = format;
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var format:String;
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns the formatted data.
		 * 
		 * @param event The log event that will converted to an specified value.
		 * @param params The first parameter after <code>event</code> must be
		 * string of date format.
		 * 
		 * @return The name of level.
		 * 
		 * @see org.log5f.events.LogEvent
		 * @see org.log5f.layouts.converters.IConverter#convert
		 */	
		public function convert(event:LogEvent):String
		{
			var formatter:DateFormatter = new DateFormatter();
			
			switch (this.format)
			{
				case "ABSOLUTE" :
					
					formatter.formatString = "YYYY/MM/DD J:NN:SS";
					
					break;
				
				case "" :
					
					formatter.formatString = "YYYY-MM-DD HH:NN:SS";
					
					break;
				
				default :
					formatter.formatString = format;
					
					break;
			}
			
			return formatter.format(new Date());
		}
	}
}