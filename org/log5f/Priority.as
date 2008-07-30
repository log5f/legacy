package org.log5f
{
	public class Priority
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const ALL:uint	= uint.MIN_VALUE;
		public static const DEBUG:uint	= 10000;
		public static const INFO:uint	= 20000;
		public static const WARN:uint	= 30000;
		public static const ERROR:uint	= 40000;
		public static const FATAL:uint	= 50000;
		public static const OFF:uint	= uint.MAX_VALUE;

		// ---------------- PRIVATE FIELDS ---------------- //

		

		// ------------------ CONSTRUCTOR ----------------- //

		public function Priority(level:uint, value:String)
		{
			this.level = level;
			this.value = value;
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		

		// --------------- PROTECTED FIELDS --------------- //

		protected var level:uint;

		protected var value:String;

		// ---------------- PUBLIC METHODS ---------------- //
		
		public function equals(o:Object):Boolean
		{
			if(o is Level)
			{
				return this.level == (o as Priority).level;
			}
			else
			{
				return false;
			}
		}
		
		public function isGreaterOrEqual(priority:Priority):Boolean
		{
			return this.level >= priority.level;
		}
		
		public function toString():String
		{
			return this.value;
		}

		public function toInt():uint
		{
			return this.level;
		}
		
		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		

		// --------------- USER INTERACTION --------------- //

	}
}