////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.StringUtil;
	
	import org.log5f.error.AppenderNotFoundError;
	import org.log5f.error.ClassNotFoundError;
	import org.log5f.error.IllegalArgumentError;
	import org.log5f.error.InvalidAppenderError;
	import org.log5f.error.InvalidConfigError;
	import org.log5f.error.SingletonError;

	//------------------------------------
	//	Events
	//------------------------------------
	
	/**
	 * Dispatches when configuration process is complete.
	 */
	[Event(eventName="complete", eventType="flash.events.Event")]

	//------------------------------------
	//	Other metadata
	//------------------------------------

	[ResourceBundle("log")]
	
	[Deprecated(replacement="Log5FConfigurator", since="1.0")]
	
	/**
	 * Configures <code>Log5F</code> for the concrete project.
	 * 
	 * 
	 * 
	 * Reads configuration from a <i>log5f.properties</i> file.
	 */
	public class PropertyConfigurator
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		/**
		 * Defines a <code>Class</code> constant for attribute <i>type</i> of
		 * <i>param</i> tag of configuration xml. 
		 */
		private static const PARAM_TYPE_CLASS:String	= "Class";

		/**
		 * Defines a <code>Number</code> constant for attribute <i>type</i> of
		 * <i>param</i> tag of configuration xml. 
		 */
		private static const PARAM_TYPE_NUMBER:String	= "Number";

		/**
		 * Defines a <code>String</code> constant for attribute <i>type</i> of
		 * <i>param</i> tag of configuration xml. 
		 */
		private static const PARAM_TYPE_STRING:String	= "String";

		/**
		 * Defines a <code>Boolean</code> constant for attribute <i>type</i> of
		 * <i>param</i> tag of configuration xml. 
		 */
		private static const PARAM_TYPE_BOOLEAN:String	= "Boolean";

		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------

		/**
		 * @private
		 * Storage for one instance of <code>PropertyConfigurator</code>.
		 */
		private static var instance:PropertyConfigurator = null;

		/**
		 * @private
		 */
		private static var properties:XML;

		/**
		 * @private
		 * The internal dispatcher, that adds functionalty of EventDispatcher to
		 * <code>PropertyConfigurator</code>.
		 */
		private static var dispatcher:EventDispatcher = new EventDispatcher();

		//----------------------------------------------------------------------
		//
		//	Class properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	configured
		//-----------------------------------
		
		/**
		 * Storeages for configured property.
		 */
		private static var _configured:Boolean = false;

		/**
		 * A flag that indicates if file "log5f.properties" is loaded and logger
		 * is configured.
		 */
		public static function get configured():Boolean
		{
			return PropertyConfigurator._configured;
		}
		
		//-----------------------------------
		//	traceErrors
		//-----------------------------------
		
		/**
		 * Storeages for configured property.
		 */
		private static var _traceErrors:Boolean = true;
		
		/**
		 * A flag that indicates need to trace error messages.
		 */
		public static function get traceErrors():Boolean
		{
			return PropertyConfigurator._traceErrors;
		}
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------

		/**
		 * Creates, if need, and returns one instance of
		 * <code>PropertyConfigurator</code>.
		 */
		public static function getInstance():PropertyConfigurator
		{
			if (instance == null)
				instance = new PropertyConfigurator();

			return instance;
		}

		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/**
		 * Constructor.
		 */
		public function PropertyConfigurator()
		{
			if (PropertyConfigurator.instance)
			{
				throw new SingletonError("PropertyConfigurator");
			}
		}

		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------

		//-----------------------------------
		//	Methods: Common
		//-----------------------------------
		
		/**
		 * Starts configuration of Log5F.
		 * 
		 * @param properties The XML from <i>log5f.properties</i> file.
		 */
		public static function configure(properties:XML):void
		{
			PropertyConfigurator.properties = properties;

			for each (var logger:XML in properties.logger)
			{
				PropertyConfigurator.configureLogger(logger);
			}

			if (properties.root != null)
				PropertyConfigurator.configureLogger(properties.root[0]);

			PropertyConfigurator._configured = true;
			
			PropertyConfigurator._traceErrors = 
				!(properties.@traceErrors == "false");
			
			PropertyConfigurator.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Creates and configures logger by xml description.
		 * 
		 * @param logger The XML node for configuration of concrete logger.
		 */
		private static function configureLogger(logger:XML):void
		{
			if (logger.@name.toString() == "" && 
				logger.name().toString() != LoggerManager.ROOT_LOGGER_NAME)
			{
				throw new InvalidConfigError(PropertyLoader.FILE);
			}

			var name:String = logger.@name.toString() == "" ? 
							  LoggerManager.ROOT_LOGGER_NAME : 
							  logger.@name.toString();

			// add level

			LoggerManager.getLogger(name).level = 
				(logger.@level != null && logger.@level.toString() != "") ? 
				Level.toLevel(logger.@level.toString()) : 
				null;

			// add appenders

			var appenders:Array = 
				StringUtil.trimArrayElements(logger.@appenders, ",").split(",");

			for each (var appenderName:String in appenders)
			{
				var node:XML = properties.appender.(@name == appenderName)[0];
				
				var appender:IAppender = 
					PropertyConfigurator.createAppender(node);

				LoggerManager.getLogger(name).addAppender(appender);
			}
		}

		//-----------------------------------
		//	Methods: IEventDispatcher
		//-----------------------------------
		
		/**
		 * @copy flash.events.IEventDispatcher#addEventListener
		 */
		public static function addEventListener(type:String, 
												listener:Function, 
												useCapture:Boolean=false, 
												priority:int=0, 
												useWeakReference:Boolean=false):void
		{
			PropertyConfigurator.dispatcher.
				addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#removeEventListener
		 */
		public static function removeEventListener(type:String, 
												   listener:Function, 
												   useCapture:Boolean=false):void
		{
			PropertyConfigurator.dispatcher.
				removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#dispatchEvent
		 */
		public static function dispatchEvent(event:Event):Boolean
		{
			return PropertyConfigurator.dispatcher.dispatchEvent(event);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#hasEventListener
		 */
		public static function hasEventListener(type:String):Boolean
		{
			return PropertyConfigurator.dispatcher.hasEventListener(type);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#willTrigger
		 */
		public static function willTrigger(type:String):Boolean
		{
			return PropertyConfigurator.dispatcher.willTrigger(type);
		}

		//-----------------------------------
		//	Methods: Creating actors
		//-----------------------------------

		/**
		 * Creates and return an appender by specified xml node.
		 *
		 * @param node The node from <code>properties</code> XML that describes
		 * concrete appender.
		 *
		 * @return The created appender.
		 *
		 * @trows InvalidConfigError, AppenderNotFoundError, InvalidAppenderError
		 */
		private static function createAppender(node:XML):IAppender
		{
			var name:String = node.@name.toString();

			var className:String = node.attribute("class").toString();

			if (!name || name == "")
				throw new InvalidConfigError(PropertyLoader.FILE);

			if (!className || className == "")
				throw new InvalidConfigError(PropertyLoader.FILE);

			try
			{
				var Appender:Class = PropertyConfigurator.createClass(className);
				var appender:IAppender = new Appender();
			}
			catch (e:ClassNotFoundError)
			{
				throw new AppenderNotFoundError(className);
			}
			catch (e:VerifyError)
			{
				throw new InvalidAppenderError(className);
			}

			appender.name = name;

			PropertyConfigurator.addParams(appender, node);

			return appender;
		}

		//-----------------------------------
		//	Methods: Utility
		//-----------------------------------

		/**
		 * The utility method that returns Class by it name.
		 *
		 * @param className The name of class that will be returned.
		 *
		 * @return The founded class
		 *
		 * @see getDefinitionByName
		 */
		private static function createClass(className:String):Class
		{
			className = PropertyConfigurator.classNameFormat(className);

			try
			{
				var Type:Class = getDefinitionByName(className) as Class;
			}
			catch (e:ReferenceError)
			{
				throw new ClassNotFoundError(className);
			}

			return Type;
		}

		/**
		 * The utility method that formats specifies class name.
		 *
		 * @param className The class name that need format.
		 *
		 * @return The Formatted class name.
		 */
		private static function classNameFormat(className:String):String
		{
			if (className.indexOf("::") != -1)
				return className;

			if (className.indexOf(".") == -1)
				return className;

			var colon:uint = className.lastIndexOf(".");

			return className.substring(0, colon) + "::" + 
				className.substring(colon + 1, className.length);
		}

		/**
		 * @trows IllegalArgumentError, ClassNotFoundError
		 */
		private static function addParams(target:Object, node:XML):void
		{
			if (!target || !node)
				return;

			for each (var param:XML in node.param)
			{
				var type:String = param.@type.toString();
				var name:String = param.@name.toString();
				var value:Object = param.@value.toString();

				if (!name || name == "" || !value)
					throw new InvalidConfigError(PropertyLoader.FILE);

				switch (type)
				{
					case PropertyConfigurator.PARAM_TYPE_CLASS :
					{
						var Type:Class = 
							PropertyConfigurator.createClass(String(value));
						
						try
						{
							value = new Type();
						}
						catch (e:ArgumentError)
						{
							throw new IllegalArgumentError(String(value));
						}

						break;
					}

					case PropertyConfigurator.PARAM_TYPE_NUMBER :
					{
						value = Number(value);

						break;
					}

					case PropertyConfigurator.PARAM_TYPE_STRING :
					{
						value = value;
						
						break;
					}

					case PropertyConfigurator.PARAM_TYPE_BOOLEAN :
					{
						value = (value == "true" || value == "yes");
						
						break;
					}

					default:
					{
						throw new InvalidConfigError(PropertyLoader.FILE);

						break;
					}
				}

				try
				{
					target[name] = value;
				}
				catch (error:TypeError)
				{
					throw new ClassNotFoundError(getQualifiedClassName(value));
				}
				
				PropertyConfigurator.addParams(value, param);
			}
		}
	}
}