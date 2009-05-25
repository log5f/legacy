////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.filters
{
	import org.log5f.events.LogEvent;
	
	/**
	 * This is a very simple filter based on string matching.
	 */
	public class StringMatchFilter extends Filter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function StringMatchFilter()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	stringToMatch
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the stringToMatch property.
		 */
		private var _stringToMatch:String;

		/**
		 * TODO Comment property
		 */
		public function get stringToMatch():String
		{
			return this._stringToMatch;
		}

		/**
		 * @private
		 */
		public function set stringToMatch(value:String):void
		{
			if (value === this._stringToMatch)
				return;
			
			this._stringToMatch = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function decide(event:LogEvent):int
		{
			if (!event.message || event.message == "")
				return Filter.NEUTRAL;
			
			if (!this.stringToMatch || this.stringToMatch == "")
				return Filter.NEUTRAL;
			
			if (event.message.toString().indexOf(this.stringToMatch) == -1)
			{
				return Filter.NEUTRAL;
			}
			else
			{
				if (this.acceptOnMatch)
					return Filter.ACCEPT;
				else
					return Filter.DENY;
			}
			
			return Filter.NEUTRAL;
		}
	}
}