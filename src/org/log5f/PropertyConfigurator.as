package org.log5f
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.StringUtil;
	
	import org.log5f.error.AppenderNotFoundError;
	import org.log5f.error.ClassNotFoundError;
	import org.log5f.error.FileNotFoundError;
	import org.log5f.error.IllegalArgumentError;
	import org.log5f.error.InvalidAppenderError;
	import org.log5f.error.InvalidFilterError;
	import org.log5f.error.InvalidPropertiesError;
	import org.log5f.filters.CommonFilter;
	
	[Event(eventName="complete", eventType="flash.events.Event")]
	
	public class PropertyConfigurator
	{
		// ----------------- STATIC FIELDS ---------------- //
		
		
		// ---------------- PRIVATE FIELDS ---------------- //

		private static var instance:PropertyConfigurator = null;
		
		private static var properties:XML;
		
		private static var dispatcher:EventDispatcher = new EventDispatcher();
		
		private static var _configured:Boolean = false;

		// ------------------ CONSTRUCTOR ----------------- //

		public function PropertyConfigurator()
		{
			if(instance)
			{
				throw new Error("PropertyConfigurator already instantiated.");
			}
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public static const PARAM_TYPE_CLASS:String		= "Class";
		public static const PARAM_TYPE_NUMBER:String	= "Number";
		public static const PARAM_TYPE_STRING:String	= "String";
		
		public static function get configured():Boolean
		{
			return PropertyConfigurator._configured;
		}
		
		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- STATIC METHODS ---------------- //
		
		public static function getInstance():PropertyConfigurator
		{
			if(instance == null)
				instance = new PropertyConfigurator();
			
			return instance;
		}
		
		// ---------------- PUBLIC METHODS ---------------- //
		
		public static function configure(properties:XML):void
		{
			trace("PropertyConfigurator.configure");
			
			PropertyConfigurator.properties = properties;
			
			for each(var logger:XML in properties.logger)
			{
				PropertyConfigurator.configureLogger(logger);
			}
			
			if(properties.root != null)
				PropertyConfigurator.configureLogger(properties.root[0]);
			
			PropertyConfigurator._configured = true;
			
			PropertyConfigurator.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			PropertyConfigurator.dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			PropertyConfigurator.dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public static function dispatchEvent(event:Event):Boolean
		{
			return PropertyConfigurator.dispatcher.dispatchEvent(event);
		}
		
		public static function hasEventListener(type:String):Boolean
		{
			return PropertyConfigurator.dispatcher.hasEventListener(type);
		}
		
		public static function willTrigger(type:String):Boolean
		{
			return PropertyConfigurator.dispatcher.willTrigger(type);
		}
		
		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //
		
		private static function configureLogger(logger:XML):void
		{
			if(logger.@name.toString() == "" && logger.name().toString() != LoggerManager.ROOT_LOGGER_NAME)
				throw InvalidPropertiesError(PropertyLoader.FILE);

			var name:String = (logger.@name.toString() == "") ? LoggerManager.ROOT_LOGGER_NAME : logger.@name.toString();
			
				// set level and filter
			
			var level:Level;
			var filter:IFilter;
			
			level = (logger.@level != null && logger.@level.toString() != "") ? Level.toLevel(logger.@level.toString()) : null;
			filter = (logger.@filter != null && logger.@filter.toString() != "") ? PropertyConfigurator.createFilter(logger.@filter.toString()) : null;
			
			LoggerManager.getLogger(name).level = level;
			
			LoggerManager.getLogger(name).filter = filter;
			
				// add appenders
			
			var appenders:Array = StringUtil.trimArrayElements(logger.@appenders, ",").split(",");
			
			for each(var appenderName:String in appenders)
			{
				var appender:IAppender = PropertyConfigurator.createAppender(properties.appender.(@name == appenderName)[0]);
				
				LoggerManager.getLogger(name).addAppender(appender);
			}
		}

		private static function createAppender(node:XML):IAppender
		{
			var name:String = node.@name.toString();
			
			var className:String = node.attribute("class").toString();
			
			if(!name || name == "")
				throw InvalidPropertiesError(PropertyLoader.FILE);

			if(!className || className == "")
				throw InvalidPropertiesError(PropertyLoader.FILE);
			
			try
			{
				var Appender:Class = PropertyConfigurator.createClass(className);
				var appender:IAppender = new Appender();
			}
			catch(e:ClassNotFoundError)
			{
				throw new AppenderNotFoundError(className);
			}
			catch(e:VerifyError)
			{
				throw new InvalidAppenderError(className);
			}
			
			appender.name = name;
			
			PropertyConfigurator.addParams(appender, node);
			
			return appender;
		}
		
		private static function createFilter(className:String):IFilter
		{
			try
			{
				var Filter:Class = PropertyConfigurator.createClass(className);
				var filter:IFilter = new Filter();
			}
			catch(e:ClassNotFoundError)
			{
				throw new FileNotFoundError(className);
			}
			catch(e:VerifyError)
			{
				throw new InvalidFilterError(className);
			}
			
			return filter;
		}
		
		private static function createClass(className:String):Class
		{
			className = PropertyConfigurator.classNameFormat(className);
			
			try
			{
				var Type:Class = getDefinitionByName(className) as Class;
			}
			catch(e:ArgumentError)
			{
				throw new IllegalArgumentError(className);
			}
			catch(e:ReferenceError)
			{
				throw new ClassNotFoundError(className);
			}
			
			return Type;
		}
		
		private static function classNameFormat(className:String):String
		{
			if(className.indexOf("::") != -1)
				return className;
			
			if(className.indexOf(".") == -1)
				return className;
			
			var colon:uint = className.lastIndexOf(".");
			
			return className.substring(0, colon) + "::" + className.substring(colon + 1, className.length);
		}
		
		private static function addParams(target:Object, node:XML):void
		{
			if(target == null || node == null)
				return;
			
			var type:String;
			var name:String;
			var value:Object;
			
			for each(var param:XML in node.param)
			{
				type = param.@type.toString();
				name = param.@name.toString();
				value = param.@value.toString();
				
				if(!name || name == "" || !value)
					throw new InvalidPropertiesError(PropertyLoader.FILE);
				
				switch(type)
				{
					case PARAM_TYPE_CLASS :
						var Type:Class = PropertyConfigurator.createClass(value as String);
						value = new Type();
					break;
					case PARAM_TYPE_NUMBER :
						value = Number(value);
					break;
					case PARAM_TYPE_STRING : 
						value = value;
					break;
					
					default : throw new InvalidPropertiesError(PropertyLoader.FILE);
				}
				
				try
				{
					target[name] = value;
				}
				catch(e:TypeError)
				{
					throw new ClassNotFoundError(getQualifiedClassName(value));
				}
				
				PropertyConfigurator.addParams(target[name], param);
			}
		}
		
		// ------------------- HANDLERS ------------------- //

	}
}