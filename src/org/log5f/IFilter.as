package org.log5f
{
	import org.log5f.events.LogEvent;
	
	public interface IFilter
	{
		function isLoggable(event:LogEvent):Boolean;
	}
}