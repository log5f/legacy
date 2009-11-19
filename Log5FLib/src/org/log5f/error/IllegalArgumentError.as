package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class IllegalArgumentError extends Error
	{
		public function IllegalArgumentError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorIllegalArgument", [className]), 2004);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}