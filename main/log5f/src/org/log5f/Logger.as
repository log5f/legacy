////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import org.log5f.core.Category;

	/**
	 * The <code>Logger</code> class has methods to retrieving loggers 
	 * (instances of <code>ILogger</code> interface). 
	 * 
	 * <pre>
	 * private static const logger:ILogger = 
	 * 	Logger.getLogger("my.package");
	 * </pre>
	 */
	public class Logger extends Category
	{
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @copy LoggerManager.getLogger()
		 */
		public static function getLogger(key:*):ILogger
		{
			return LoggerManager.getLogger(key);
		}

		/**
		 * @copy LoggerManager.getRootLogger()
		 */
		public static function getRootLogger():ILogger
		{
			return LoggerManager.getRootLogger();
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param The name of logger.
		 */
		public function Logger(name:String)
		{
			super(name);
		}
	}
}