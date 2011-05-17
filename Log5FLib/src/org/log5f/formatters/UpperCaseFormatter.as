package org.log5f.formatters
{
	import org.log5f.core.IFormatter;
	import org.log5f.events.LogEvent;

	public class UpperCaseFormatter implements IFormatter
	{
		public function UpperCaseFormatter()
		{
		}

		public function format(event:LogEvent):LogEvent
		{
			event.message = event.message.toUpperCase();
			
			return event;
		}
		
	}
}