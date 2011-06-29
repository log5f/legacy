////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import org.log5f.core.Priority;
	
	/**
	 * Defines a set of priority levels that used for logging.
	 */
	public class Level extends Priority
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		/**
		 * Disables logging.
		 * 
		 * @see Priority.OFF
		 */
		public static const OFF:Level	= new Level(Priority.OFF,	Priority.OFF_LABEL);

		/**
		 * Designates log event with <code>FATAL</code> priority.
		 * 
		 * @see Priority.FATAL
		 */
		public static const FATAL:Level	= new Level(Priority.FATAL,	Priority.FATAL_LABEL);
		
		/**
		 * Designates log event with <code>ERROR</code> priority.
		 * 
		 * @see Priority.ERROR
		 */
		public static const ERROR:Level	= new Level(Priority.ERROR,	Priority.ERROR_LABEL);
		
		/**
		 * Designates log event with <code>WARN</code> priority.
		 * 
		 * @see Priority.WARN
		 */
		public static const WARN:Level	= new Level(Priority.WARN,	Priority.WARN_LABEL);
		
		/**
		 * Designates log event with <code>FATAL</code> priority.
		 * 
		 * @see Priority.INFO
		 */
		public static const INFO:Level	= new Level(Priority.INFO,	Priority.INFO_LABEL);
		
		/**
		 * Designates log event with <code>FATAL</code> priority.
		 * 
		 * @see Priority.DEBUG
		 */
		public static const DEBUG:Level	= new Level(Priority.DEBUG,	Priority.DEBUG_LABEL);
		
		/**
		 * Designates log event with <code>FATAL</code> priority.
		 * 
		 * @see Priority.ALL
		 */
		public static const ALL:Level	= new Level(Priority.ALL,	Priority.ALL_LABEL);

		/**
		 * The default logging level is DEBUG.
		 * 
		 * @default DEBUG
		 */
		public static const DEFAULT:Level = DEBUG;
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Converts string or integer to <code>Level</code>.
		 * 
		 * @param value Integer or String that represents some priority level.
		 * 
		 * @return Specified or default level. 
		 */
		public static function toLevel(value:Object):Level
		{
			if(value is String)
				return stringToLevel(value as String);
			else if(value is uint)
				return uintToLevel(value as uint);
			
			return DEFAULT;
		}
		
		/**
		 * Converts string to <code>Level</code>.
		 * 
		 * @param value String that represents some priority level.
		 * 
		 * @return Specified or default level. 
		 */
		private static function stringToLevel(value:String):Level
		{
			switch(value)
			{
				case "ALL"		: return Level.ALL; break;
				case "DEBUG"	: return Level.DEBUG; break;
				case "INFO"		: return Level.INFO; break;
				case "WARN"		: return Level.WARN; break;
				case "ERROR"	: return Level.ERROR; break;
				case "FATAL"	: return Level.FATAL; break;
				case "OFF"		: return Level.OFF; break;
				
				default			: return DEFAULT;
			}
		}
		
		/**
		 * Converts integer to <code>Level</code>.
		 * 
		 * @param value Integer that represents some priority level.
		 * 
		 * @return Specified or default level. 
		 */
		private static function uintToLevel(value:uint):Level
		{
			switch(value)
			{
				case uint.MIN_VALUE	: return Level.ALL;
				case 10000			: return Level.DEBUG;
				case 20000			: return Level.INFO;
				case 30000			: return Level.WARN;
				case 40000			: return Level.ERROR;
				case 50000			: return Level.FATAL;
				case uint.MAX_VALUE : return Level.OFF;
					
				default : return DEFAULT;
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param level An integer that represents priority level.
		 * @param value A string that represents a name of priority level.
		 */
		public function Level(level:uint, value:String)
		{
			super(level, value);
		}
	}
}