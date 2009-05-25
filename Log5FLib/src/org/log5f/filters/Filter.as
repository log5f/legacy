////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.filters
{
	import mx.resources.ResourceManager;
	
	import org.log5f.events.LogEvent;
	
	/**
	 * The abstract class of base filter, you should extend this class to 
	 * implement customized logging event filtering.
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
		
		/**
		 * @private
		 * Storage for the next property.
		 */
		private var _next:Filter;

		/**
		 * The pointer to the next filter. 
		 */
		public function get next():Filter
		{
			return this._next;
		}

		/**
		 * @private
		 */
		public function set next(value:Filter):void
		{
			if (value === this._next)
				return;
			
			this._next = value;
		}
		
		//-----------------------------------
		//	acceptOnMatch
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the acceptOnMatch property.
		 */
		private var _acceptOnMatch:Boolean = true;

		/**
		 * 
		 */
		public function get acceptOnMatch():Boolean
		{
			return this._acceptOnMatch;
		}

		/**
		 * @private
		 */
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
		 * @param event The LoggingEvent to decide upon.
		 * @return decision The decision of the filter.
		 **/
		public function decide(event:LogEvent):int
		{
			throw new Error(ResourceManager.getInstance().
								getString("log5f", "errorAbstractMethod"));
		}
	}
}