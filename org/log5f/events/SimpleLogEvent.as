package org.log5f.events
{
	public class SimpleLogEvent
	{
		// ------------------ CONSTRUCTOR ----------------- //

		public function SimpleLogEvent(category:String, level:uint, connectionName:String, message:String, packageName:String=null, className:String=null, methodName:String=null)
		{
			super();
			
			this.level = level;
			this.message = message;
			this.category = category;
			this.packageName = packageName;
			this.className = className;
			this.methodName = methodName;
			this.connectionName = connectionName;
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public var level:uint;
		
		public var message:String;
		
		public var category:String;
		
		public var packageName:String;
		
		public var className:String;
		
		public var methodName:String;

		public var connectionName:String;
		
		// ---------------- PUBLIC METHODS ---------------- //

		
		public function clone():SimpleLogEvent
		{
			return new SimpleLogEvent(this.category, this.level, this.connectionName, this.message, this.packageName, this.className, this.methodName);
		}

	}
}