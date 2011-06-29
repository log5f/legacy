////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.filters
{
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	
	/**
	 * This is a very simple filter based on level matching, which can be used 
	 * to reject messages with priorities outside a certain range.
	 */
	public class LevelRangeFilter extends Filter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LevelRangeFilter()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	levelMin
		//-----------------------------------
		
		/** Storage for the levelMin property. */
		private var _levelMin:String;

		/**
		 * The string interpretation of minimum level.
		 */
		public function get levelMin():String
		{
			return this._levelMin;
		}

		/** @private */
		public function set levelMin(value:String):void
		{
			if (value === this._levelMin)
				return;
			
			this._levelMin = value;
		}

		//-----------------------------------
		//	levelMax
		//-----------------------------------
		
		/** Storage for the levelMax property. */
		private var _levelMax:String;

		/**
		 * The string interpretation of maximum level.
		 */
		public function get levelMax():String
		{
			return this._levelMax;
		}

		/** @private */
		public function set levelMax(value:String):void
		{
			if (value === this._levelMax)
				return;
			
			this._levelMax = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		/** @inheritDoc */
		override public function decide(event:LogEvent):int
		{
			var min:Level = Level.toLevel(this.levelMin);
			
			var max:Level = Level.toLevel(this.levelMax);
			
			if (min && event.level.toInt() < min.toInt())
				return Filter.DENY;
				
				
			if (max && event.level.toInt() > max.toInt())
				return Filter.DENY;
			
			return this.acceptOnMatch ? Filter.ACCEPT : Filter.NEUTRAL;
		}
	}
}