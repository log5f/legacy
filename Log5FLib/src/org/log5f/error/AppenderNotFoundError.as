package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class AppenderNotFoundError extends Error
	{
		public function AppenderNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorAppenderNotFound", [className]), 2102);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}