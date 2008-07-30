package org.log5f.filters
{
	import org.log5f.IFilter;
	import org.log5f.events.LogEvent;
	
	public class CommonFilter implements IFilter
	{
		public function CommonFilter()
		{
		}

		public function isLoggable(event:LogEvent):Boolean
		{
			return true;
		}
		
	}
}