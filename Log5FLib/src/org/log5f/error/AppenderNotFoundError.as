package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;
	
	public class AppenderNotFoundError extends Error
	{
		public function AppenderNotFoundError(className:String)
		{
			super(ResourceManager.instance.
				getString("errorAppenderNotFound", [className]), 2102);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}