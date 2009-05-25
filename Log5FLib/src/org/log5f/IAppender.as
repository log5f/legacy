package org.log5f
{
	import org.log5f.events.LogEvent;
	import org.log5f.filters.Filter;
	
	public interface IAppender
	{
		/**
		 * The name of this appender.
		 * The name uniquely identifies the appender.
		 */
		function get name():String;
		/**
		 * @private
		 */
		function set name(value:String):void;
		
		/**
		 * The layout for this appender.
		 * 
		 * @see org.log5f.Layout
		 */
		function get layout():Layout;
		/**
		 * @private
		 */
		function set layout(value:Layout):void;
		
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