////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts
{
	import org.log5f.core.ILayout;
	import org.log5f.events.LogEvent;
	
	/**
	 * SimpleLayout consists of the level of the log statement, 
	 * followed by " - " and then the log message itself. For example,
	 * <pre>
	 * 		DEBUG - Hello world
	 * </pre>
	 */
	public class SimpleLayout implements ILayout
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function SimpleLayout()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns <code>false</code> - the <code>SimpleLayot</code> doesn't 
		 * need information from the stack.
		 */
		public function get isStackNeeded():Boolean
		{
			return false;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns the log statement in a format consisting of the
		 * <code>level</code>, followed by " - " and then the
		 * <code>message</code>. For example, <pre> INFO - "A message"
		 * </pre>
		 * 
		 * <p>The <code>category</code> parameter is ignored.</p>
		 * 
		 * @return A string in SimpleLayout format.
		 */
		public function format(event:LogEvent):String
		{
			return event.level.toString() + " - " + event.message + "\n";
		}
	}
}