package org.log5f.core
{
	import org.log5f.events.LogEvent;
	
	public interface IFormatter
	{
		function format(event:LogEvent):LogEvent;
	}
}