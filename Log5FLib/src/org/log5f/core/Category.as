////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import flash.events.Event;
	import flash.system.Capabilities;
	
	import org.log5f.Level;
	import org.log5f.LoggerManager;
	import org.log5f.core.config.Configurator;
	import org.log5f.core.managers.DeferredManager;
	import org.log5f.events.LogEvent;
	import org.log5f.log5f_internal;

	/**
	 * 
	 */
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
			this._name = name;
			
			this._category = name;
		}

		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------

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
			
			if (!this.parent || this.parent == this)
				return false;
			
			return this.parent.useStack;
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
		//	isDebugEnabled
		//-----------------------------------
		
		/**
		 * Check if this category is enabled for <code>DEBUG</code> level.
		 */
		public function get isDebugEnabled():Boolean
		{
			return Level.DEBUG.isGreaterOrEqual(this.getEffectiveLevel());
		}
		
		//-----------------------------------
		//	isInfoEnabled
		//-----------------------------------
		
		/**
		 * Check if this category is enabled for <code>INFO</code> level.
		 */
		public function get isInfoEnabled():Boolean
		{
			return Level.INFO.isGreaterOrEqual(this.getEffectiveLevel());
		}
		
		//-----------------------------------
		//	isWarningEnabled
		//-----------------------------------
		
		/**
		 * Check if this category is enabled for <code>WARN</code> level.
		 */
		public function get isWarningEnabled():Boolean
		{
			return Level.WARN.isGreaterOrEqual(this.getEffectiveLevel());
		}
		
		//-----------------------------------
		//	isErrorEnabled
		//-----------------------------------
		
		/**
		 * Check if this category is enabled for <code>ERROR</code> level.
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
		//	Methods: Logging
		//-----------------------------------

		/**
		 * This method logs with <code>DEBUG</code> level.
		 */
		public function debug(...rest):void
		{
			this.log(Level.DEBUG, rest);
		}

		/**
		 * This method logs with <code>INFO</code> level.
		 */
		public function info(...rest):void
		{
			this.log(Level.INFO, rest);
		}

		/**
		 * This method logs with <code>WARN</code> level.
		 */
		public function warn(...rest):void
		{
			this.log(Level.WARN, rest);
		}

		/**
		 * This method logs with <code>ERROR</code> level.
		 */
		public function error(...rest):void
		{
			this.log(Level.ERROR, rest);
		}

		/**
		 * This method logs with <code>FATAL</code> level.
		 */
		public function fatal(...rest):void
		{
			this.log(Level.FATAL, rest);
		}
		
		//-----------------------------------
		//	Methods: Common
		//-----------------------------------
		
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
			
			// if Log5F isn't configured - defer log entry
			
			if (Configurator.log5f_internal::needUpdate)
			{
				DeferredManager.log5f_internal::addLog(this, level, message, stack);
				
				Configurator.log5f_internal::update();
				
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
			
			if (!Capabilities.isDebugger)
			{
				this.log5f_internal::log(level, message);
				
				return;
			}
			
			// stack is not used 
			
			if (!this.useStack && !Configurator.log5f_internal::needUpdate)
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