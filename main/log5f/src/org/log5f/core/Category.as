////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import flash.events.Event;
	import flash.system.Capabilities;
	
	import mx.utils.StringUtil;
	
	import org.log5f.ILogger;
	import org.log5f.Level;
	import org.log5f.LoggerManager;
	import org.log5f.core.config.Config;
	import org.log5f.core.managers.DeferredManager;
	import org.log5f.events.LogEvent;
	import org.log5f.log5f_internal;

	/**
	 * 
	 */
	public class Category implements IAppenderAttachable, ILogger
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
			this._name = name;
		}

		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		private var appenders:AppenderAttachable;

		/**
		 * @private
		 * A flag that indicates if <code>useStack</code> is set manually.
		 */
		private var useStackManual:Boolean = false;
		
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
		 * The name of category.
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
		 * The priority level of the category.
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
		}

		//-----------------------------------
		//	category
		//-----------------------------------

		/**
		 * The string representation of the category name. Returns same value
		 * that <code>name</code> property.
		 */
		public function get category():String
		{
			return this._name;
		}

		//-----------------------------------
		//	useStack
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for useStack property.
		 */
		private var _useStack:Boolean;
		
		/**
		 * A flag that indicates if stack is used.
		 */
		public function get useStack():Boolean
		{
			if (this.useStackManual)
				return this._useStack;
			
			for each (var appender:IAppender in this.getAllAppenders())
			{
				if (appender.layout.isStackNeeded)
					return true;
			}
			
			var parent:Category = this.parent;
			
			if (!parent || parent == this)
			{
				return false;
			}
			
			return parent.useStack;
		}
		
		/**
		 * @private
		 */
		public function set useStack(value:Boolean):void
		{
			this._useStack = value;
			
			this.useStackManual = true;
		}
		
		//-----------------------------------
		//	Properties: Checking API
		//-----------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function get isDebugEnabled():Boolean
		{
			return Level.DEBUG.isGreaterOrEqual(this.getEffectiveLevel());
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isInfoEnabled():Boolean
		{
			return Level.INFO.isGreaterOrEqual(this.getEffectiveLevel());
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isWarningEnabled():Boolean
		{
			return Level.WARN.isGreaterOrEqual(this.getEffectiveLevel());
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isErrorEnabled():Boolean
		{
			return Level.ERROR.isGreaterOrEqual(this.getEffectiveLevel());
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------

		//-----------------------------------
		//	Methods: IAppenderAttachable
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
		
		//-----------------------------------
		//	Methods: ILogger
		//-----------------------------------

		/**
		 * @inheritDoc
		 */
		public function debug(...args):void
		{
			this.log(Level.DEBUG, args);
		}

		/**
		 * @inheritDoc
		 */
		public function info(...args):void
		{
			this.log(Level.INFO, args);
		}

		/**
		 * @inheritDoc
		 */
		public function warn(...args):void
		{
			this.log(Level.WARN, args);
		}

		/**
		 * @inheritDoc
		 */
		public function error(...args):void
		{
			this.log(Level.ERROR, args);
		}

		/**
		 * @inheritDoc
		 */
		public function fatal(...args):void
		{
			this.log(Level.FATAL, args);
		}
		
		//-----------------------------------
		//	Methods: Logging 
		//-----------------------------------
		
		/**
		 * Gets call stack if need and call <code>log</code> method.
		 * 
		 * @param level The specified level
		 *
		 * @param message The message to logging.
		 */
		protected function log(level:Level, message:Object):void
		{
			// stack is not available - release version of the Flash Player
			
			message = this.substituteMessage(message);
			
			if (!Capabilities.isDebugger)
			{
				this.log5f_internal::log(level, message);
				
				return;
			}
			
			// stack is not used 
			
			if (!this.useStack && !Config.log5f_internal::needUpdate)
			{
				this.log5f_internal::log(level, message);
				
				return;
			}
			
			// stack is used
			
			try
			{
				throw new Error();
			}
			catch (error:Error)
			{
				this.log5f_internal::log(level, message, error.getStackTrace());
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
		log5f_internal function log(level:Level, message:Object, stack:String=null):void
		{
			if (!LoggerManager.log5f_internal::enabled)
			{
				return;
			}
			
			// defer log entry, if Log5F isn't configured yet
			
			if (Config.log5f_internal::needUpdate)
			{
				DeferredManager.log5f_internal::addLog(this, level, message, stack);
				
				Config.log5f_internal::update();
				
				return;
			}
			
			if (!level.isGreaterOrEqual(this.getEffectiveLevel()))
				return;
			
			var event:LogEvent = new LogEvent(this, level, message, stack);
			
			for (var c:Category = this; c != null; c = c.parent)
			{
				if (level.isGreaterOrEqual(c.getEffectiveLevel()))
					c.callAppenders(event);
			}
		}
		
		//-----------------------------------
		//	Methods: Internal
		//-----------------------------------
		
		/**
		 * Calculates and returns effective log level.
		 * 
		 * @return The effective log level.
		 */
		protected function getEffectiveLevel():Level
		{
			for (var c:Category = this; c != null; c = c.parent)
			{
				if (c.level)
					return c.level;
			}

			return null;
		}
		
		/**
		 * @private
		 */
		private function substituteMessage(message:Object):Object
		{
			if (!(message is Array) || message.length < 2) return message;
			
			var string:String = message[0] as String;
			
			var pattern:RegExp = /\{\d+.?\}/g;
			
			if (!pattern.test(string)) return message;
			
			message.shift();
			
			return StringUtil.substitute(string, message as Array);
		}
		
		//-----------------------------------
		//	Methods: Objects
		//-----------------------------------
		
		/**
		 * Returns category's name and level in readable form.
		 * 
		 * @return The category's name and level in readable form.
		 */
		public function toString():String
		{
			return '[Category name="' + this.name + 
				   '" level="' + this.level + '"]';
		}
	}
}