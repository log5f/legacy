////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	import org.log5f.core.Appender;
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>TraceAppender</code> appends log events to the 
	 * <code>trace</code> method.
	 */
	public class TraceAppender extends Appender
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/**
		 * Constructor.
		 */
		public function TraceAppender()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Overriden methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Appends log events to <code>trace</code>.
		 */
		override protected function append(event:LogEvent):void
		{
			trace(this.layout.format(event));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function close():void
		{
		}
	}
}