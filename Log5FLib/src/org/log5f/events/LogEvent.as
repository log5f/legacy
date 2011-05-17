package org.log5f.events
{
	import org.log5f.core.Category;
	import org.log5f.Level;
	
	public class LogEvent
	{
		// ----------------- STATIC FIELDS ---------------- //

		

		// ---------------- PRIVATE FIELDS ---------------- //

		

		// ------------------ CONSTRUCTOR ----------------- //

		public function LogEvent(category:Category, level:Level, message:Object, stack:String=null)
		{
			super();
			
			this.level = level;
			this.message = message;
			this.category = category;
			this.stack = stack;
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public var level:Level;
		
		public var message:Object;
		
		public var category:Category;

		public var stack:String;
		
		[Deprecated("")]
		public var packageName:String;
		
		[Deprecated("")]
		public var className:String;
		
		[Deprecated("")]
		public var methodName:String;
		
		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

		
		public function clone():LogEvent
		{
			return new LogEvent(this.category, this.level, this.message);
		}

		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

	}
}