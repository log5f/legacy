////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.helpers.deferred
{
	import org.log5f.Category;
	import org.log5f.Level;
	import org.log5f.core.LogEntry;
	import org.log5f.log5f_internal;

	/**
	 * TODO Add asdocs
	 */
	public class DeferredLogs
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function DeferredLogs()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 * Contains deferred logs.
		 */
		private var logs:Array = null;
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Stores specified log entry for process it after.
		 * 
		 * @param category The category of a defferd log entry.
		 * @param level The level of a defferd log entry.
		 * @param message The message of a defferd log entry.
		 */
		public function addLog(category:Category,level:Level, message:Object):void
		{
			if (!this.logs)
				this.logs = [];
			
			this.logs.push(new DeferredLog(category, level, message));
		}

		/**
		 * Removes all deferred log entries, used if configuration process is 
		 * fail.
		 */
		public function removeLogs():void
		{
			if (this.logs == null)
				return;
			
			this.logs = null;
		}
		
		/**
		 * Processes deferred log entries.
		 */
		public function processLogs():void
		{
			if (this.logs == null)
				return;
			
			for (var log:DeferredLog = this.logs.shift(); log; log = this.logs.shift())
			{
				log.category.log5f_internal::log(log.level, log.message);
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	Event handlers
		//
		//----------------------------------------------------------------------
		
	}
}

import org.log5f.Category;
import org.log5f.Level;

/**
 * @private
 */
internal class DeferredLog
{
	public function DeferredLog(category:Category, level:Level, message:Object)
	{
		this.category = category;
		this.level = level;
		this.message = message;
	}

	public var category:Category;
	
	public var level:Level;
	
	public var message:Object;
}