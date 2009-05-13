package org.log5f
{
	import org.log5f.events.LogEvent;

	public class Filter implements IFilter
	{
		public function Filter()
		{
		}

		public function isLoggable(event:LogEvent):Boolean
		{
			return false;
		}
		
	}
}