////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.filters
{
	import org.log5f.events.LogEvent;
	
	/**
	 * This filter drops all logging events.
	 */
	public class DenyAllFilter extends Filter
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function DenyAllFilter()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		/** @inheritDoc */
		override public function decide(event:LogEvent):int
		{
			return Filter.DENY;
		}
	}
}