////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	import org.log5f.events.LogEvent;
	import org.log5f.filters.Filter;
	
	/**
	 * The <code>IAppender</code> is an interface that each appender must 
	 * implement. The appenders are used for work with different logging 
	 * targets, their task is to pass the <code>LogEvent</code> instances to 
	 * logging target in appropriate format. 
	 * <br />
	 * Each concrete appender work with one concrete logging target. For 
	 * example, <code>TraceAppender</code> work with console, as a logging 
	 * target, by using the global <code>trace()</code> method.
	 * <br />
	 * This interface defines methods for setting layouts and filters, and for 
	 * passing log events to logging target. 
	 */
	public interface IAppender
	{
		/**
		 * The name of this appender, this name is an uniquely identifier for 
		 * the appender.
		 */
		function get name():String;
		
		/** @private */
		function set name(value:String):void;
		
		/**
		 * The layout for this appender.
		 * 
		 * @see org.log5f.Layout
		 */
		function get layout():ILayout;
		
		/** @private */
		function set layout(value:ILayout):void;
		
		/**
		 * The head filter.
		 * 
		 * The Filters are organized in a linked list and so all Filters on 
		 * this Appender are available through the result.
		 */
		function get filter():Filter;
		
		/**
		 * Adds a filter to the end of the filter list.
		 */
		function set filter(value:Filter):void;
		
		/**
		 * Add a filter to the end of the filter list.
		 */
		function addFilter(filter:Filter):void;
		
		/**
		 * Clears the filters chain.
		 */
		function clearFilters():void
		
		/**
		 * Log in <code>Appender</code> specific way.
		 */
		function doAppend(event:LogEvent):void;
		
		/**
		 * Release any resources allocated within the appender.
		 */
		function close():void;
	}
}