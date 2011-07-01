////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.events
{
	import org.log5f.core.Category;
	import org.log5f.Level;
	
	/**
	 * The <code>LogEvent</code> class represents an object that describes a log
	 * event. 
	 */
	public class LogEvent
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param category The category that produces this log event.
		 * @param level The priority level for this log event. 
		 * @param message The object to logging.
		 * @param stack The string that contains calling stack, used for getting
		 * special information (e.g. class and method names). 
		 */
		public function LogEvent(category:Category, level:Level, message:Object, stack:String=null)
		{
			super();
			
			this._category = category;
			this._level = level;
			this._message = message;
			this._stack = stack;
		}

		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	category
		//-----------------------------------
		
		/** Storage for the category property. */
		private var _category:Category;

		/**
		 * The category that produces this log event.
		 */
		public function get category():Category
		{
			return this._category;
		}
		
		//-----------------------------------
		//	level
		//-----------------------------------
		
		/** Storage for the level property. */
		private var _level:Level;

		/**
		 * The priority level of this log event.
		 */
		public function get level():Level
		{
			return this._level;
		}

		//-----------------------------------
		//	message
		//-----------------------------------
		
		/** Storage for the message property. */
		private var _message:Object;

		/**
		 * Th message to logging.
		 */
		public function get message():Object
		{
			return this._message;
		}

		//-----------------------------------
		//	stack
		//-----------------------------------
		
		/** Storage for the stack property. */
		private var _stack:String;

		/**
		 * Contains additional information.
		 */
		public function get stack():String
		{
			return this._stack;
		}

		//----------------------------------------------------------------------
		//
		//	Public methods
		//
		//----------------------------------------------------------------------

		/**
		 * Clones this log event.
		 * 
		 * @return The new instance of <code>LogEvent</code> with same values of
		 * properties that this log event.
		 */
		public function clone():LogEvent
		{
			return new LogEvent(this.category, this.level, this.message, this.stack);
		}
	}
}