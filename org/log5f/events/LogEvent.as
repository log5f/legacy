package org.log5f.events
{
	import org.log5f.Category;
	import org.log5f.Level;
	
	import flash.utils.getQualifiedClassName;
	
	public class LogEvent
	{
		// ----------------- STATIC FIELDS ---------------- //

		

		// ---------------- PRIVATE FIELDS ---------------- //

		

		// ------------------ CONSTRUCTOR ----------------- //

		public function LogEvent(category:Category, level:Level, message:Object, target:Object=null)
		{
			super();
			
			this.level = level;
			this.message = message;
			this.category = category;
			
			var targetName:String = getQualifiedClassName(target);
			
			this.packageName = targetName.substring(0, targetName.indexOf("::"));
			this.className = targetName.substring(targetName.indexOf("::") + 2, targetName.length);
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public var level:Level;
		
		public var message:Object;
		
		public var category:Category;
		
		public var packageName:String;
		
		public var className:String;
		
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