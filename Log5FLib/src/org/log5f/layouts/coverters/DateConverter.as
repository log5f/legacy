package org.log5f.layouts.coverters
{
	import mx.formatters.DateFormatter;
	
	import org.log5f.IConverter;
	import org.log5f.events.LogEvent;
	
	public class DateConverter implements IConverter
	{
		public function DateConverter()
		{
		}
		
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
		 * @see org.log5f.layouts.coverters.IConverter#convert
		 */
		public function convert(event:LogEvent):String
		{
			var formatter:DateFormatter = new DateFormatter();
			
			var format:String = "ABSOLUTE";
			
			switch (format)
			{
				case "ABSOLUTE" :
				{
					formatter.formatString = "YYYY/MM/DD J:NN:SS";
					
					break;
				}
				
				default :
				{
					formatter.formatString = format;
					
					break;
				}
			}
			
			return formatter.format(new Date());
		}
	}
}