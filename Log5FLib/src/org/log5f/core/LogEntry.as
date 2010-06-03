////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import org.log5f.Category;
	import org.log5f.Level;

	/**
	 * Represents log entry.
	 */
	public class LogEntry
	{
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LogEntry(category:Category, level:Level, message:Object, stack:String=null)
		{
			super();
			
			this.level = level;
			this.message = message;
			this.category = category;
			this.stack = stack;
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * Level of log entry.
		 */
		public var level:Level;
		
		/**
		 * The message.
		 */
		public var message:Object;
		
		/**
		 * Category of the log entry.
		 */
		public var category:Category;
		
		/**
		 * Error stack.
		 */
		public var stack:String;
	}
}