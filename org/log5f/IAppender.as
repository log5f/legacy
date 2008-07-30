package org.log5f
{
	import org.log5f.events.LogEvent;
	
	public interface IAppender
	{
		function get name():String;
		function set name(value:String):void;

		function get layout():ILayout;
		function set layout(value:ILayout):void;
		
		function close():void;
		function doAppend(event:LogEvent):void;
	}
}