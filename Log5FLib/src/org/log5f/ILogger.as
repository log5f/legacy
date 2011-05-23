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
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Properties: Checking API
		//-----------------------------------
		
		/**
		 * Check if this category is enabled for <code>DEBUG</code> level.
		 */
		function get isDebugEnabled():Boolean;
		
		/**
		 * Check if this category is enabled for <code>INFO</code> level.
		 */
		function get isInfoEnabled():Boolean;
		
		/**
		 * Check if this category is enabled for <code>WARN</code> level.
		 */
		function get isWarningEnabled():Boolean;
		
		/**
		 * Check if this category is enabled for <code>ERROR</code> level.
		 */
		function get isErrorEnabled():Boolean;
		
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Methods: Logging API
		//-----------------------------------
		
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