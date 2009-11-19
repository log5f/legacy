package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class InvalidAppenderError extends Error
	{
		public function InvalidAppenderError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorInvalidAppender", [className]), 2201);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}