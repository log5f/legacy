package org.log5f
{
	import org.log5f.events.LogEvent;
	
	public interface ILayout
	{
		function get conversionPattern():String;
		function set conversionPattern(value:String):void;
		
		function format(event:LogEvent):String
	}
}