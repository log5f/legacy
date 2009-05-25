/**
 * Додати відкаладене завантаження до завантаження файлу з налаштунками.
 */
package org.log5f
{
	import flash.events.Event;
	import flash.system.Capabilities;
	
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.PatternLayout;

	public class Category implements IAppenderAttachable
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
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
		public function Category(name:String)
		{
			this.name = name;
		}

		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------

		private var appenders:AppenderAttachable;

		[ArrayElementType("LogObject")]
		private var lazyLogEvents:Array;

		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------

		//-----------------------------------
		//	name
		//-----------------------------------

		/**
		 * Storage for the name property.
		 */
		private var _name:String;

		/**
		 *
		 */
		public function get name():String
		{
			return this._name;
		}

		/**
		 * @private
		 */
		public function set name(value:String):void
		{
			this._name = value;
		}

		//-----------------------------------
		//	level
		//-----------------------------------

		/**
		 * Storage for the level property.
		 */
		private var _level:Level;

		/**
		 *
		 */
		public function get level():Level
		{
			return this._level;
		}

		/**
		 * @private
		 */
		public function set level(value:Level):void
		{
			this._level = value;
		}

		//-----------------------------------
		//	filter
		//-----------------------------------

		/**
		 * Storage for the filter property.
		 */
		private var _filter:IFilter;

		/**
		 *
		 */
		public function get filter():IFilter
		{
			return this._filter;
		}

		/**
		 * @private
		 */
		public function set filter(value:IFilter):void
		{
			this._filter = value;
		}

		//-----------------------------------
		//	parent
		//-----------------------------------

		/**
		 * Storage for the category property.
		 */
		private var _parent:Category;

		/**
		 * The parent category, for root category this property is <code>null</code>.
		 */
		public function get parent():Category
		{
			return this._parent;
		}

		/**
		 * @private
		 */
		public function set parent(value:Category):void
		{
			this._parent = value;

			this.category = this.name;

//			this.category = this.parent != LoggerManager.getRootLogger() ?
//							this.parent.name :
//							this.name;
		}

		//-----------------------------------
		//	category
		//-----------------------------------

		/**
		 * Storage for the category property.
		 */
		private var _category:String;

		/**
		 *
		 */
		public function get category():String
		{
			return this._category;
		}

		/**
		 * @private
		 */
		public function set category(value:String):void
		{
			this._category = value;
		}

		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------

		//-----------------------------------
		//	Methods: Appenders
		//-----------------------------------

		/**
		 * Adds appender for this category.
		 *
		 * @param appender The appender that will be added.
		 */
		public function addAppender(appender:IAppender):void
		{
			if (!this.appenders)
				this.appenders = new AppenderAttachable();

			this.appenders.addAppender(appender);
		}

		/**
		 * Returns all appender of this category.
		 *
		 * @return An array of appenders.
		 */
		public function getAllAppenders():Array
		{
			if (!this.appenders)
				return null;

			return this.appenders.getAllAppenders();
		}

		/**
		 * Gets appender by it name.
		 *
		 * @param name The name of appender.
		 *
		 * @return The appender with specified name.
		 */
		public function getAppender(name:String):IAppender
		{
			if (!this.appenders)
				return null;

			return this.appenders.getAppender(name);
		}

		/**
		 * Specifies if appender is added to this category.
		 *
		 * @param The appender to find.
		 *
		 * @return The <code>true</code> if specified appender found in appenders
		 * list, <code>false</code> - otherwise.
		 */
		public function isAttached(appender:IAppender):Boolean
		{
			if (!this.appenders)
				return false;

			return this.appenders.isAttached(appender);
		}

		/**
		 * Removes all appenders.
		 */
		public function removeAllAppenders():void
		{
			if (!this.appenders)
				return;

			return this.appenders.removeAllAppenders();
		}

		/**
		 * Remove specified appender.
		 *
		 * @param key Can be appender or it name.
		 */
		public function removeAppender(key:Object):void
		{
			if (!this.appenders)
				return;

			return this.appenders.removeAppender(key);
		}

		//-----------------------------------
		//	Methods: Logger
		//-----------------------------------

		/**
		 * This method logs with <code>DEBUG</code> level.
		 *
		 * @param message The string to log.
		 */
		public function debug(message:Object):void
		{
			this.log5f_internal::log(Level.DEBUG, message);
		}

		/**
		 * This method logs with <code>INFO</code> level.
		 *
		 * @param message The string to log.
		 */
		public function info(message:Object):void
		{
			this.log5f_internal::log(Level.INFO, message);
		}

		/**
		 * This method logs with <code>WARN</code> level.
		 *
		 * @param message The string to log.
		 */
		public function warn(message:Object):void
		{
			this.log5f_internal::log(Level.WARN, message);
		}

		/**
		 * This method logs with <code>ERROR</code> level.
		 *
		 * @param message The string to log.
		 */
		public function error(message:Object):void
		{
			this.log5f_internal::log(Level.ERROR, message);
		}

		/**
		 * This method logs with <code>FATAL</code> level.
		 *
		 * @param message The string to log.
		 */
		public function fatal(message:Object):void
		{
			this.log5f_internal::log(Level.FATAL, message);
		}
		
		/**
		 * Gets call stack if need and call <code>log</code> method.
		 * 
		 * @param level The specified level
		 *
		 * @param message The message to logging.
		 */
		log5f_internal function log(level:Level, message:Object):void
		{
			// if relese flash player stack not available
			
			if (!Capabilities.isDebugger)
			{
				this.log(level, message);
				
				return;
			}
			
			// define if stack is used
			
			var stackIsUsed:Boolean = false;

			for each (var appender:IAppender in this.getAllAppenders())
			{
				var pattern:String = appender.layout.conversionPattern;

				PatternLayout.CONVERSION_PATTERN_FILE.lastIndex = 0;
				PatternLayout.CONVERSION_PATTERN_METHOD.lastIndex = 0;
				PatternLayout.CONVERSION_PATTERN_LINE_NUMBER.lastIndex = 0;

				if (PatternLayout.CONVERSION_PATTERN_FILE.test(pattern) || 
					PatternLayout.CONVERSION_PATTERN_METHOD.test(pattern) || 
					PatternLayout.CONVERSION_PATTERN_LINE_NUMBER.test(pattern))
				{
					stackIsUsed = true;

					break;
				}
			}
			
			// if stack is not used and roperties file is loaded
			
			if (!stackIsUsed && PropertyConfigurator.configured)
			{
				this.log(level, message);

				return;
			}
			
			// if stack is used
			
			try
			{
				throw new Error();
			}
			catch (error:Error)
			{
				this.log(level, message, error.getStackTrace());
			}
		}
		
		/**
		 * This method call appenders for logging message.
		 *
		 * @param level The specified level
		 *
		 * @param message The message to logging.
		 *
		 * @param stack The string representation of the call stack.
		 */
		protected function log(level:Level, message:Object, stack:String=null):void
		{
			if (!PropertyConfigurator.configured)
			{
				PropertyConfigurator.addEventListener(Event.COMPLETE, 
													  this.propertiesCompleteHandler);

				this.lazyLog(level, message, stack);

				return;
			}

			if (!level.isGreaterOrEqual(this.getEffectiveLevel()))
				return;

			var event:LogEvent = new LogEvent(this, level, message, stack);

			if (!this.isLoggable(event))
				return;

			for (var c:Category = this; c != null; c = c.parent)
			{
				if (level.isGreaterOrEqual(c.getEffectiveLevel()))
					c.callAppenders(event);
			}
		}

		/**
		 * This method used if properties file is not loaded yet.
		 *
		 * @param level The specified level
		 *
		 * @param message The message to logging.
		 *
		 * @param stack The string representation of the call stack.
		 */
		protected function lazyLog(level:Level, message:Object, stack:String=null):void
		{
			if (this.lazyLogEvents == null)
				this.lazyLogEvents = [];

			this.lazyLogEvents.push(new LogObject(level, message, stack));
		}
		
		/**
		 * Calculates and returns effective log level.
		 * 
		 * @return The effective log level.
		 */
		public function getEffectiveLevel():Level
		{
			for (var c:Category = this; c != null; c = c.parent)
			{
				if (c.level)
					return c.level;
			}

			return null;
		}
		
		/**
		 * Calls <code>doAppend</code> method of all appenders.
		 * 
		 * @param event The log event.
		 * 
		 * @see org.log5f.IAppender#doAppend
		 */
		public function callAppenders(event:LogEvent):void
		{
			for each (var appender:IAppender in this.getAllAppenders())
			{
				appender.doAppend(event);
			}
		}

		/**
		 * Specifies if log event is loggable for this category.
		 * 
		 * @param event The log event.
		 * 
		 * @return <code>true</code> if specified log event is loggable for this
		 * category, <code>false</code> if it is not loggable.
		 * 
		 * @see org.log5f.IFilter#isLoggable
		 */
		private function isLoggable(event:LogEvent):Boolean
		{
			if (this.filter == null)
				return true;

			return this.filter.isLoggable(event);
		}
		
		/**
		 * Returns category's name and level in readable form.
		 * 
		 * @return The category's name and level in readable form.
		 */
		public function toString():String
		{
			return '[Category name="' + this.name + 
				   '" level="' + this.level.toString() + '"]';
		}
		
		//----------------------------------------------------------------------
		//
		//	Event handlers
		//
		//----------------------------------------------------------------------

		/**
		 * The handler of "propertiesComplete" event of
		 * <code>PropertyConfigurator</code>.
		 *
		 * @param event The "propertiesComplete" event.
		 */
		protected function propertiesCompleteHandler(event:Event):void
		{
			PropertyConfigurator.removeEventListener(Event.COMPLETE, 
													 this.propertiesCompleteHandler);

			if (!this.lazyLogEvents || this.lazyLogEvents.length == 0)
				return;
			
			var logs:Array = this.lazyLogEvents;
			
			for (var data:LogObject = logs.shift(); data; data = logs.shift())
			{
				this.log(data.level, data.message, data.stack);
			}
		}

	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: DateConverter
//
////////////////////////////////////////////////////////////////////////////////

import org.log5f.Level;

/**
 * This is helper class that used for lazy log functionality.
 */
class LogObject
{
	public var level:Level;

	public var message:Object;

	public var stack:String;

	function LogObject(level:Level=null, message:Object=null, stack:String=null)
	{
		super();

		this.level = level;
		this.message = message;
		this.stack = stack;
	}
}