package org.log5f
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import org.log5f.appenders.FirebugAppender;
	import org.log5f.appenders.PysarAppender;
	import org.log5f.appenders.TraceAppender;
	import org.log5f.appenders.XPanelAppender;
	import org.log5f.filters.CommonFilter;
	import org.log5f.formatters.UpperCaseFormatter;
	import org.log5f.layouts.PatternLayout;
	
	public class LoggerManager
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const ROOT_LOGGER_NAME:String = "root";

		// ---------------- PRIVATE FIELDS ---------------- //

		private static var loggers:Object;
		
		private static var filters:Array;
		private static var layouts:Array;
		private static var appenders:Array;
		private static var formatters:Array;
		
		private namespace log5f_internal = "http://code.google.com/p/log5f";
		
		// ------------------ CONSTRUCTOR ----------------- //

		public function LoggerManager()
		{
			LoggerManager.registerFilter(CommonFilter);
			
			LoggerManager.registerLayout(PatternLayout);
			
			LoggerManager.registerAppender(PysarAppender);
			LoggerManager.registerAppender(TraceAppender);
			LoggerManager.registerAppender(XPanelAppender);
			LoggerManager.registerAppender(FirebugAppender);

			LoggerManager.registerFormatter(UpperCaseFormatter)
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- STATIC METHODS ---------------- //
		
		public static function getRootLogger():Logger
		{
			return getLogger(ROOT_LOGGER_NAME);
		}
		
		/**
		 * @param key
		 */
		public static function getLogger(key:*):Logger
		{
			var name:String;
			
			if(key is String)
			{
				name = key as String;
			}
			else if(key is Class || key is Object)
			{
				var info:XML = describeType(key);
				
				name = info.@name[0].toString().replace("::", ".");
			}	
			
			return log5f_internal::getLogger(name);
		}
		
		log5f_internal static function getLogger(name:String):Logger
		{
			PropertyLoader.load();
			
			if(loggers == null)
				loggers = {};
			
			name = (name == null || name == "") ? ROOT_LOGGER_NAME : name;
			
			if(!loggers[name])
			{
				loggers[name] = new Logger(name);
				insertInHierarchy(loggers[name]);
			}
			
			return loggers[name];
		}
		
		public static function registerFilter(filter:Class):void
		{
			if(filter == null)
				return;
			
			if(filters == null)
				filters = [];
			
			filters.push(filter);
		}
		
		public static function registerLayout(layout:Class):void
		{
			if(layout == null)
				return;
			
			if(layouts == null)
				layouts = [];
			
			layouts.push(layout);
		}
		
		public static function registerAppender(appender:Class):void
		{
			if(appender == null)
				return;
			
			if(appenders == null)
				appenders = [];
			
			appenders.push(appender);
		}
		
		public static function registerFormatter(formatter:Class):void
		{
			if(formatter == null)
				return;
			
			if(formatters == null)
				formatters = [];
			
			formatters.push(formatter);
		}
		
		private static function insertInHierarchy(logger:Logger):void
		{
			var child:Logger;
			
			for each(var l:Logger in loggers)
			{
				if(l == logger)
					continue;
				
				if(l.name.indexOf(logger.name) == 0 && (child == null || l.name.length < child.name.length))
					child = l;
			}
			
			if(child != null)
				child.parent = logger;
			
			if(logger == LoggerManager.getRootLogger())
				return;
			
			//TODO: rename
			var temp:Array = logger.name.split(".");
			temp.pop();
			
			while (temp.length > 0)
			{
				var name:String = temp.join(".");
				
				if(loggers[name] != undefined)
				{
					logger.parent = loggers[name];
					break;
				}
				else
				{
					temp.pop();
				}
			}
			
			if(logger.parent == null)
				logger.parent = LoggerManager.getRootLogger();
		}
		
		// ---------------- PUBLIC METHODS ---------------- //

		

		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		

		// --------------- USER INTERACTION --------------- //

	}
}