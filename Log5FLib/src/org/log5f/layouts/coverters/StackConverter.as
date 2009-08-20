////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts.coverters
{
	import org.log5f.IConverter;
	import org.log5f.events.LogEvent;

	/**
	 * Base class for converting call stack from a log event to specified stack
	 * part.
	 */
	public class StackConverter implements IConverter
	{
		//----------------------------------------------------------------------
		//
		//	Constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * The regular expression for parsing call stack.
		 */
		public static const PATTERN:RegExp = 
			/\tat (?:(.+)::)(.+)\/*(.*)\(\)\[(?:(.+)\:(\d+))?\]$/gs;
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param part The part of call stack that should be founded. Use 
		 * <code>StackPart</code> constants for this parameter.
		 * 
		 * @see org.log5f.layouts.coverters.StackPart
		 */
		public function StackConverter(part:int)
		{
			super();
			
			this.part = part;
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * The part of call stack that should be founded. 
		 */
		private var part:int = 0;
		
		//----------------------------------------------------------------------
		//
		//	Methods: IConverter
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns a value of specified part of call stack.
		 * 
		 * This method uses regular expression that based on Jonathan Branams 
		 * regular expression.
		 * 
		 * @param event The log event that contains an information about call
		 * stack.
		 * 
		 * @return The specified part from concrete call stack.
		 * 
		 * @see org.log5f.events.LogEvent#stak org.log5f.events.LogEvent.stak 
		 * @see http://github.com/jonathanbranam/360flex08_presocode/ Jonathan Branams Presentation
		 */
		public function convert(event:LogEvent):String
		{
			if (!event.stack || event.stack == "")
				return "";
			
//			StackConverter.PATTERN.lastIndex = 0;
			
			var pattern:RegExp = /^\tat (?:(.+)::)?(.+)\/*(.*)\(\)\[(?:(.+)\:(\d+))?\]$/;

			var stack:Array = event.stack.split("\n");
			
			var matches:Object = stack[3].match(pattern);
			
			return matches[this.part];
		}
	}
}