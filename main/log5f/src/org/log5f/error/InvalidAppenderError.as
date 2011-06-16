package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;
	
	public class InvalidAppenderError extends Error
	{
		public function InvalidAppenderError(className:String)
		{
			super(ResourceManager.instance.
				getString("errorInvalidAppender", [className]), 2201);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}