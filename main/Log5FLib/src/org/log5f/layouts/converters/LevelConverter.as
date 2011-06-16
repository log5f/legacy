////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.converters
{
	import org.log5f.events.LogEvent;
	
	/**
	 * Converts log event to a level's name.
	 */
	public class LevelConverter implements IConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param precision The number of characters for priority.
		 */
		public function LevelConverter(precision:int=0)
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
		 * Returns the level's name of log event.
		 * 
		 * @param event The log event that will converted to an specified value.
		 * 
		 * @return The name of level.
		 * 
		 * @see org.log5f.events.LogEvent
		 * @see org.log5f.layouts.converters.IConverter#convert
		 */
		public function convert(event:LogEvent):String
		{
			var levelName:String = event.level.toString();
			
			if (this.precision == 0)
				this.precision = levelName.length;
			
			if (this.precision <= levelName.length)
				return levelName.substr(0, this.precision);
			
			var n:int = this.precision - levelName.length;
			for (var i:int = 0; i < n; i++)
			{
				levelName += " ";
			}
			
			return levelName;
		}
	}
}