////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	/**
	 * The interface for logger.
	 * 
	 * <p>This interface defines the logging methods for different log levels.</p>
	 */
	public interface ILogger
	{
		/**
		 * Logs the message specified in <code>rest</code> aurguments with the 
		 * <code>DEBUG</code> level.
		 * 
		 * @param rest The array of objects that will be converted to string and
		 * logged.
		 * 
		 * @see Level.DEBUG
		 */
		function debug(...rest):void;

		/**
		 * Logs the message specified in <code>rest</code> aurguments with the 
		 * <code>INFO</code> level.
		 * 
		 * @param rest The array of objects that will be converted to string and
		 * logged.
		 * 
		 * @see Level.INFO
		 */
		function info(...rest):void;
		
		/**
		 * Logs the message specified in <code>rest</code> aurguments with the 
		 * <code>WARN</code> level.
		 * 
		 * @param rest The array of objects that will be converted to string and
		 * logged.
		 * 
		 * @see Level.WARN
		 */
		function warn(...rest):void;
		
		/**
		 * Logs the message specified in <code>rest</code> aurguments with the 
		 * <code>ERROR</code> level.
		 * 
		 * @param rest The array of objects that will be converted to string and
		 * logged.
		 * 
		 * @see Level.ERROR
		 */
		function error(...rest):void;
		
		/**
		 * Logs the message specified in <code>rest</code> aurguments with the 
		 * <code>FATAL</code> level.
		 * 
		 * @param rest The array of objects that will be converted to string and
		 * logged.
		 * 
		 * @see Level.FATAL
		 */
		function fatal(...rest):void;
	}
}