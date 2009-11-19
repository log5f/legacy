package org.log5f.error
{
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class InvalidConfigError extends Error
	{
		public function InvalidConfigError(file:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorInvalidConfig", [file]), 2002);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}