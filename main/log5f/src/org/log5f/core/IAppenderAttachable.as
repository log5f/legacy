////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	/**
	 * Defines methods for work with appenders list.
	 */
	public interface IAppenderAttachable
	{
		/**
		 * Adds specified appender into list.
		 * 
		 * @param appender An appender that will be added to appenders list.
		 */
		function addAppender(appender:IAppender):void;

		/**
		 * Returns appenders list
		 * 
		 * @return The list of all added appenders.
		 */
		function getAllAppenders():Array;

		/**
		 * Retrieve appender by name.
		 * 
		 * @param name The name of appender that will be returned.
		 * 
		 * @return The appender with specified name, or <code>null</code> - if
		 * that appender is not found.
		 */
		function getAppender(name:String):IAppender;

		/**
		 * Checks if the specified appender is in appenders list.
		 * 
		 * @param appender The appender to checking.
		 * 
		 * @return <code>true</code> is specified appender is in appenders list, 
		 * or <code>false</code> - otherwise.
		 */
		function isAttached(appender:IAppender):Boolean;

		/**
		 * Removes all appenders from the list.
		 */
		function removeAllAppenders():void;

		/**
		 * Remove specified appender or appender with specified name (if key is 
		 * string) from the appenders list.
		 * 
		 * @param key Can be an instance of the implementation of 
		 * <code>IAppender</code>, or string a name of appender.
		 */
		function removeAppender(key:Object):void;
	}
}