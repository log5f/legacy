////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.filters
{
	import org.log5f.helpers.resources.ResourceManager;
	
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>Filter</code> is a base class for all filters, it provides
	 * possibility to organize filters into the linked list. The filters are 
	 * used for dropping some log events.
	 */
	public class Filter
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * The log event must be dropped immediately without consulting
		 * with the remaining filters, if any, in the chain.
		 */
		public static const DENY:int	= -1;

		/**
		 * This filter is neutral with respect to the log event. The
		 * remaining filters, if any, should be consulted for a final decision.
		 */
		public static const NEUTRAL:int	= 0;

		/**
		 * The log event must be logged immediately without consulting with
		 * the remaining filters, if any, in the chain.
		 */
		public static const ACCEPT:int	= 1;
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Filter()
		{
			super();
		}

		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	next
		//-----------------------------------
		
		/** Storage for the next property. */
		private var _next:Filter;

		/**
		 * The pointer to the next filter. 
		 */
		public function get next():Filter
		{
			return this._next;
		}

		/** @private */
		public function set next(value:Filter):void
		{
			if (value === this._next)
				return;
			
			this._next = value;
		}
		
		//-----------------------------------
		//	acceptOnMatch
		//-----------------------------------
		
		/** Storage for the acceptOnMatch property. */
		private var _acceptOnMatch:Boolean = true;

		/**
		 * The flag that defines if the filter will work in including if 
		 * <code>true</code>, or excluding if <code>false</code> mode.
		 */
		public function get acceptOnMatch():Boolean
		{
			return this._acceptOnMatch;
		}

		/** @private */
		public function set acceptOnMatch(value:Boolean):void
		{
			if (value === this._acceptOnMatch)
				return;
			
			this._acceptOnMatch = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * <p>If the decision is <code>DENY</code>, then the event will be
		 * dropped. If the decision is <code>NEUTRAL</code>, then the next
		 * filter, if any, will be invoked. If the decision is ACCEPT then
		 * the event will be logged without consulting with other filters in
		 * the chain.
		 * 
		 * <p><b>Note</b>: This method is an abstract and must be overridden.</p>
		 * 
		 * @param event The LoggingEvent to decide upon.
		 * @return decision The decision of the filter.
		 **/
		public function decide(event:LogEvent):int
		{
            throw new Error(ResourceManager.instance.
				getString("errorAbstractMethod"));
		}
	}
}