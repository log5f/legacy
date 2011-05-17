////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	public class Priority
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		public static const ALL:uint	= uint.MIN_VALUE;
		public static const DEBUG:uint	= 10000;
		public static const INFO:uint	= 20000;
		public static const WARN:uint	= 30000;
		public static const ERROR:uint	= 40000;
		public static const FATAL:uint	= 50000;
		public static const OFF:uint	= uint.MAX_VALUE;

		public static const ALL_LABEL:String	= "ALL";
		public static const DEBUG_LABEL:String	= "DEBUG";
		public static const INFO_LABEL:String	= "INFO";
		public static const WARN_LABEL:String	= "WARN";
		public static const ERROR_LABEL:String	= "ERROR";
		public static const FATAL_LABEL:String	= "FATAL";
		public static const OFF_LABEL:String	= "OFF";
		
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
		public function Priority(level:uint, value:String)
		{
			super();
			
			this.level = level;
			this.value = value;
		}

		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var level:uint;

		/**
		 * @private
		 */
		protected var value:String;

		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Compares priorities.
		 * 
		 * Compares <code>level</code> of the specified priority with own 
		 * <code>level</code> and returns <code>true</code> if these are equals, 
		 * or <code>false</code> otherwise.
		 * 
		 * @param priority Priority to compare.
		 * 
		 * @return <code>true</code> if levels of properties is equals, or 
		 * <code>false</code> otherwise.
		 */
		public function equals(priority:Priority):Boolean
		{
			return this.level == priority.level;
		}
		
		/**
		 * Compares priorities.
		 * 
		 * Compares <code>level</code> of the specified priority with own 
		 * <code>level</code> and returns <code>true</code> if own level is 
		 * great or egual, or <code>false</code> otherwise.
		 * 
		 * @param priority Priority to compare.
		 * 
		 * @return <code>true</code> if own level is great or egual, or 
		 * <code>false</code> otherwise.
		 */
		public function isGreaterOrEqual(priority:Priority):Boolean
		{
			return this.level >= priority.level;
		}
		
		/**
		 * Returns <code>value</code> of the priority.
		 * 
		 * @return <code>value</code> of the priority.
		 */
		public function toString():String
		{
			return this.value;
		}
		
		/**
		 * Returns <code>level</code> of the priority.
		 * 
		 * @return <code>level</code> of the priority.
		 */
		public function toInt():uint
		{
			return this.level;
		}

	}
}