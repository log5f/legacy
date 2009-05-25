////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import mx.resources.ResourceManager;
	
	import org.log5f.events.LogEvent;
	
	/**
	 * The base class for all layouts.
	 */
	public class Layout
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Layout()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Subclasses of <code>Layout</code> should implement this method to 
		 * perform actual logging.
		 */
		public function format(event:LogEvent):String
		{
			throw new Error(ResourceManager.getInstance().
								getString("log5f", "errorAbstractMethod"));
		}
	}
}