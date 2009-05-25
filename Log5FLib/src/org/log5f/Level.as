package org.log5f
{
	import flash.utils.ByteArray;
	
	public class Level extends Priority
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const OFF:Level	= new Level(Priority.OFF,	"OFF");
		public static const FATAL:Level	= new Level(Priority.FATAL,	"FATAL");
		public static const ERROR:Level	= new Level(Priority.ERROR,	"ERROR");
		public static const WARN:Level	= new Level(Priority.WARN,	"WARN");
		public static const INFO:Level	= new Level(Priority.INFO,	"INFO");
		public static const DEBUG:Level	= new Level(Priority.DEBUG,	"DEBUG");
		public static const ALL:Level	= new Level(Priority.ALL,	"ALL");

		public static var DEFAULT:Level = DEBUG;
		
		// ---------------- PRIVATE FIELDS ---------------- //

		
		
		// ------------------ CONSTRUCTOR ----------------- //

		public function Level(level:uint, value:String)
		{
			super(level, value);
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- STATIC METHODS ---------------- //
		
		public static function toLevel(value:Object):Level
		{
			if(value is String)
				return stringToLevel(value as String);
			else if(value is uint)
				return uintToLevel(value as uint);
				
			return DEFAULT;
		}
		
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
		
		// ---------------- PUBLIC METHODS ---------------- //
		
		/**
		 * Deserialize
		 * TODO:
		 */
		public function readObject(bytes:ByteArray):void
		{
			
		}
		
		/**
		 * Serialize
		 * TODO:
		 */
		public function writeObject(bytes:ByteArray):void
		{
			
		}
		
		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		

		// --------------- USER INTERACTION --------------- //

	}
}