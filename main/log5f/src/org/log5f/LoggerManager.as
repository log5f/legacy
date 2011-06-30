////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
    import flash.utils.describeType;
    
    import org.log5f.appenders.ArthropodAppender;
    import org.log5f.appenders.BrowserAppender;
    import org.log5f.appenders.FirebugAppender;
    import org.log5f.appenders.LocalConnectionAppender;
    import org.log5f.appenders.TraceAppender;
    import org.log5f.appenders.XMLSocketAppender;
    import org.log5f.appenders.XPanelAppender;
    import org.log5f.core.config.Config;
    import org.log5f.filters.DenyAllFilter;
    import org.log5f.filters.LevelRangeFilter;
    import org.log5f.filters.StringMatchFilter;
    import org.log5f.layouts.Log4JLayout;
    import org.log5f.layouts.PatternLayout;
    import org.log5f.layouts.SimpleLayout;
    import org.log5f.layouts.ThunderBoltLayout;
	
	use namespace log5f_internal;
	
	/**
	 * The <code>LoggerManager</code> class contains public methods for 
	 * configuration Log5F:
	 * 
	 * <pre>
	 * // allows to configure from remote file
	 * LoggerManager.configure("http://example.com/log5f/config.xml");
	 * 
	 * // and from remote file
	 * LoggerManager.configure(<config>...</config>);
	 * 
	 * // checking if tracing errors is enabled
	 * trace(LoggerManager.traceErrors);
	 * </pre>
	 * 
	 * It contains two methods for retrieving loggers, but these methods are 
	 * deprecated, and replaced by static methods from the <code>Logger</code>
	 * class.
	 * 
	 * <pre>
	 * 
	 * package my
	 * {
	 * import org.log5f.Logger;
	 * import org.log5f.ILogger;
	 * 
	 * 	public class MyClass
	 * 	{
	 * 		private static const logger:ILogger = Logger.getLogger(MyClass);
	 * 		...
	 * 	}
	 * }
	 * 
	 * </pre>
	 * 
	 * <p>
	 * Under the hood the <code>LoggerManager</code> creates hierarchical 
	 * structure of the <code>Logger</code> classes and store it.
	 * </p>
	 * 
	 * @see org.log5f.Logger 
	 * @see org.log5f.ILogger 
	 */
    public class LoggerManager
    {
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * The name of root logger.
		 */
        public static const ROOT_LOGGER_NAME:String = "root";

        //----------------------------------------------------------------------
        //
        //	Class variables
        //
        //----------------------------------------------------------------------
		
		/**
		 * Stores all loggers which creating in the process of working of 
		 * application.
		 */
		private static var loggers:Object;

		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	ready
		//-----------------------------------
		
		/**
		 * Storage for enabled property.
		 */
		private static var _enabled:Boolean = true;
		
		/**
		 * Indicates if Log5F is <i>enabled</i>.
		 * 
		 * <p>If this property is <code>true</code> this means that least one 
		 * configuration process was successfull.</p>
		 * 
		 * <p><b>Note</b>: If this property is <code>false</code>, all logs
		 * will be ignored.</p>
		 *   
		 */
		log5f_internal static function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * @private
		 */
		log5f_internal static function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Class methods: Configuration
		//-----------------------------------
		
		/**
		 * @copy Config.configure()
		 */
		public static function configure(source:Object):void
		{
			Config.configure(source);
		}
		
		/**
		 * @copy Config.traceErrors
		 */
		public static function get traceErrors():Boolean
		{
			return Config.traceErrors;
		}
		
		//-----------------------------------
		//	Class methods: Retrieving 
		//-----------------------------------
		
		
		/**
		 * Retrives root logger.
		 * 
		 * @return Root logger.
		 */
        public static function getRootLogger():Logger
        {
            return getLogger(ROOT_LOGGER_NAME);
        }

		/**
		 * Retrieves the appropriate <code>Logger</code> instance.
		 * 
		 * @param key Specifies category of creating logger. This parameter can 
		 * be a string or class or an instance.
		 * 
		 * @return Appropriate logger.
		 */
        public static function getLogger(key:*):Logger
        {
            var name:String;

            if (key is String)
            {
                name = key as String;
            }
            else if (key is Class || key is Object)
            {
                var info:XML = describeType(key);

                name = info.@name[0].toString().replace("::", ".");
            }

            return getLoggerByName(name);
        }
		
		/**
		 * Retrives or creates appropriate <code>Logger</code> instance.
		 * 
		 * @param name The name of category of Logger.
		 * 
		 * @return Appropriate logger.
		 * 
		 * @see org.log5f.Logger#category
		 */
        protected static function getLoggerByName(name:String):Logger
        {
            if (loggers == null)
                loggers = {};

            name = (name == null || name == "") ? ROOT_LOGGER_NAME : name;

            if (!loggers[name])
            {
                loggers[name] = new Logger(name);
                insertInHierarchy(loggers[name]);
            }

            return loggers[name];
        }
		
		/**
		 * This method does nothing, it used for force compile specified class.
		 * 
		 * You can create custom appenders, filters, formatters and layouts, but 
		 * they are not using in project, usually. Therefore flash compiler 
		 * doesn't compile they into result swf. For resolving this issue you
		 * can use this method.
		 * 
		 * <pre>
		 * LoggerManager.forceCompile(MyAppender);
		 * </pre>
		 * 
		 * @param someClass A some class that is not used explicitly in project, 
		 * but can be instantiated during run time.
		 */
		public static function forceCompile(someClass:Class):void
		{
			// stub
		}
		
		/**
		 * Inserts specified logger into hierarchy.
		 * 
		 * @param logger The logger that need add to hierarchy.
		 */
        private static function insertInHierarchy(logger:Logger):void
        {
        	// find children
        	
        	for each (var child:Logger in loggers)
        	{
        		if (child == logger)
        			continue;
        		
        		if (child.name.indexOf(logger.name) != 0)
        			continue;
        		
        		if (child.parent == LoggerManager.getRootLogger() || 
					child.parent.name.length > logger.name.length)
    			{
					child.parent = logger;
    			}
        	}
        	
        	// find parent
        	
        	var packages:Array = logger.name.split(".");
        	
        	packages.pop();
        	
        	while (packages.length > 0)
        	{
        		var name:String = packages.join(".");
        		
        		if (loggers[name])
        		{
        			logger.parent = loggers[name];
        			
        			break;
        		}
        		
        		packages.pop();
        	}
        	
        	if (!logger.parent && logger != LoggerManager.getRootLogger())
        		logger.parent = LoggerManager.getRootLogger();
        }
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LoggerManager()
		{
			super();
			
			LoggerManager.forceCompile(DenyAllFilter);
			LoggerManager.forceCompile(LevelRangeFilter);
			LoggerManager.forceCompile(StringMatchFilter);
			
			LoggerManager.forceCompile(Log4JLayout);
			LoggerManager.forceCompile(SimpleLayout);
			LoggerManager.forceCompile(PatternLayout);
			LoggerManager.forceCompile(ThunderBoltLayout);
			
			LoggerManager.forceCompile(TraceAppender);
			LoggerManager.forceCompile(XPanelAppender);
			LoggerManager.forceCompile(BrowserAppender);
			LoggerManager.forceCompile(FirebugAppender);
			LoggerManager.forceCompile(XMLSocketAppender);
			LoggerManager.forceCompile(ArthropodAppender);
			LoggerManager.forceCompile(LocalConnectionAppender);
		}
    }
}