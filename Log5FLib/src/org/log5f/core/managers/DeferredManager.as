////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.managers
{
	import org.log5f.core.Category;
	import org.log5f.Level;
	import org.log5f.log5f_internal;

	[ExcludeClass]
	
	/**
	 * Manages deferred log entries.
	 */
	public class DeferredManager
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
		
		/**
		 * @private
		 * Contains deferred logs.
		 */
		private static var logs:Array = null;
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Stores specified log entry for process it after.
		 * 
		 * @param category The category of a defferd log entry.
		 * @param level The level of a defferd log entry.
		 * @param message The message of a defferd log entry.
		 */
		log5f_internal static function addLog(category:Category, level:Level, message:Object, stack:String=null):void
		{
			if (!logs)
				logs = [];
			
			logs.push(new DeferredLog(category, level, message, stack));
		}
		
		/**
		 * Removes all deferred log entries, used if configuration process is 
		 * fail.
		 */
		log5f_internal static function removeLogs():void
		{
			if (!logs)
				return;
			
			logs = null;
		}
		
		/**
		 * Processes deferred log entries.
		 */
		log5f_internal static function proceedLogs():void
		{
			if (!logs)
				return;
			
			for (var log:DeferredLog = logs.shift(); log; log = logs.shift())
			{
				log.category.log5f_internal::log(log.level, log.message, log.stack);
			}
		}
	}
}

import org.log5f.core.Category;
import org.log5f.Level;

/**
 * @private
 */
internal class DeferredLog
{
	public function DeferredLog(category:Category, level:Level, message:Object, stack:String=null)
	{
		this.category = category;
		this.level = level;
		this.message = message;
		this.stack = stack;
	}

	public var category:Category;
	
	public var level:Level;
	
	public var message:Object;

	public var stack:String;
}