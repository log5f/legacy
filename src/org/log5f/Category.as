/**
 * Додати відкаладене завантаження до завантаження файлу з налаштунками.
 */
package org.log5f
{
	import org.log5f.events.LogEvent;
	
	import flash.events.Event;
	
	public class Category implements IAppenderAttachable
	{
		// ----------------- STATIC FIELDS ---------------- //

		

		// ---------------- PRIVATE FIELDS ---------------- //

		private var appenders:AppenderAttachable;
		
		[ArrayElementType("LogObject")]
		private var lazyLogEvents:Array;
		
		private var _name:String;
		
		private var _level:Level;
		
		private var _filter:IFilter;
		
		private var _parent:Category;
		
		private var _category:String;

		// ------------------ CONSTRUCTOR ----------------- //

		public function Category(name:String)
		{
			this.name = name;
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public function get name():String
		{
			return this._name;
		}
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		public function get level():Level
		{
			return this._level;
		}
		public function set level(value:Level):void
		{
			this._level = value;
		}
		
		public function get filter():IFilter
		{
			return this._filter;
		}
		public function set filter(value:IFilter):void
		{
			this._filter = value;
		}
		
		public function get parent():Category
		{
			return this._parent;
		}
		public function set parent(value:Category):void
		{
			this._parent = value;
			
			if(this.parent != LoggerManager.getRootLogger())
				this.category = this.name.substring(this.parent.name.length + 1, this.name.length);
			else
				this.category = this.name;
		}
		
		public function get category():String
		{
			return this._category;
		}
		public function set category(value:String):void
		{
			this._category = value;
		}
		
		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

		public function addAppender(appender:IAppender):void
		{
			if(this.appenders == null)
				this.appenders = new AppenderAttachable();
				
			this.appenders.addAppender(appender);
		}
		
		public function getAllAppenders():Array
		{
			if(this.appenders == null)
				return null;
			
			return this.appenders.getAllAppenders();
		}
		
		public function getAppender(name:String):IAppender
		{
			if(this.appenders == null)
				return null;
				
			return this.appenders.getAppender(name);
		}
		
		public function isAttached(appender:IAppender):Boolean
		{
			if(this.appenders == null)
				return false;
				
			return this.appenders.isAttached(appender);
		}
		
		public function removeAllAppenders():void
		{
			if(this.appenders == null)
				return;
				
			return this.appenders.removeAllAppenders();
		}
		
		public function removeAppender(key:Object):void
		{
			if(this.appenders == null)
				return;
				
			return this.appenders.removeAppender(key);
		}
		
		public function debug(message:Object, target:Object=null):void
		{
			this.log(Level.DEBUG, message, target);
		}

		public function info(message:Object, target:Object=null):void
		{
			this.log(Level.INFO, message, target);
		}
		
		public function warn(message:Object, target:Object=null):void
		{
			this.log(Level.WARN, message, target);
		}
		
		public function error(message:Object, target:Object=null):void
		{
			this.log(Level.ERROR, message, target);
		}
		
		public function fatal(message:Object, target:Object=null):void
		{
			this.log(Level.FATAL, message, target);
		}
		
		public function getEffectiveLevel():Level
		{
			for(var c:Category = this; c != null; c = c.parent)
			{
				if(c.level != null)
					return c.level;
			}
			
			return null;
		}
		
		public function callAppenders(event:LogEvent):void
		{
			for each(var appender:IAppender in this.getAllAppenders())
			{
				appender.doAppend(event);
			}
		}
		
		public function toString():String
		{
			return '[Category name="' + this.name + '" level="' + this.level.toString() + '"]';
		}
		
		// --------------- PROTECTED METHODS -------------- //

		protected function log(level:Level, message:Object, target:Object=null):void
		{
			if(!PropertyConfigurator.configured)
			{
				PropertyConfigurator.addEventListener(Event.COMPLETE, this.propertiesCompleteHandler);
				this.lazyLog(level, message);
				return;
			}
			
			if(!level.isGreaterOrEqual(this.getEffectiveLevel()))
				return;
			
			var event:LogEvent = new LogEvent(this, level, message, target);
			
			if(!this.isLoggable(event))
				return;
			
			for(var c:Category = this; c != null; c = c.parent)
			{
				if(level.isGreaterOrEqual(c.getEffectiveLevel()))
					c.callAppenders(event);
			}
		}
		
		protected function lazyLog(level:Level, message:Object, target:Object=null):void
		{
			if(this.lazyLogEvents == null)
				this.lazyLogEvents = [];
				
			this.lazyLogEvents.push(new LogObject(level, message, target));
		}
		
		// ---------------- PRIVATE METHODS --------------- //
		
		private function isLoggable(event:LogEvent):Boolean
		{
			if(this.filter == null)
				return true;
				
			return this.filter.isLoggable(event);
		}

		// ------------------- HANDLERS ------------------- //

		protected function propertiesCompleteHandler(event:Event):void
		{
			PropertyConfigurator.removeEventListener(Event.COMPLETE, this.propertiesCompleteHandler);
			
			if(this.lazyLogEvents == null || this.lazyLogEvents.length == 0)
				return;
			
			var data:LogObject = this.lazyLogEvents.shift() as LogObject;
			
			while(data)
			{
				this.log(data.level, data.message, data.target);
				
				data = this.lazyLogEvents.shift() as LogObject;
			}
		}

		// --------------- USER INTERACTION --------------- //

	}
}

import org.log5f.Level;

class LogObject 
{
	public var level:Level;
	
	public var message:Object;
	
	public var target:Object;
	
	function LogObject(level:Level=null, message:Object=null, target:Object=null)
	{
		super();
		
		this.level = level;
		this.message = message;
		this.target = target;
	}
}