package org.log5f
{
	import org.log5f.events.LogEvent;
	
	public interface IFormatter
	{
		function format(event:LogEvent):LogEvent;
	}
}