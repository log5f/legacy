////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	import flash.external.ExternalInterface;
	
	import org.log5f.core.Appender;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	
	/**
	 * The <code>BrowserAppender</code> appends log events to the Browser's
	 * console.
	 * 
	 * @see http://wiki.log5f.org/wiki/Appenders/
	 */
	public class BrowserAppender extends Appender
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/**
		 * Constructor.
		 */
		public function BrowserAppender()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Overriden methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Appends log events to <code>Firebug</code> by ExternalInterface.
		 */
		override protected function append(event:LogEvent):void
		{
			if (!ExternalInterface.available)
				return;
			
			var method:String;
			
			switch (event.level.toInt())
			{
				case Level.ALL.toInt() : 
				{
					method = "function(message){try{console.log(message);}catch(e){}}";
					
					break;
				}
				
				case Level.DEBUG.toInt() :
				{
					method = "function(message){try{console.debug(message);}catch(e){}}";
					
					break;
				}
				
				case Level.INFO.toInt() : 
				{
					method = "function(message){try{console.info(message);}catch(e){}}";
					
					break;
				}
				
				case Level.WARN.toInt() : 
				{
					method = "function(message){try{console.warn(message);}catch(e){}}";
					
					break;
				}
				
				case Level.ERROR.toInt() :
				{
					method = "function(message){try{console.error(message);}catch(e){}}"; 
					
					break;
				} 
				
				case Level.FATAL.toInt() : 
				{
					method = "function(message){try{console.error(message);}catch(e){}}";

					break;
				}
				
				case Level.OFF.toInt() : 
				default :
				{
					break;
				}
			}
			
			ExternalInterface.call(method, this.layout.format(event));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function close():void
		{
		}
	}
}