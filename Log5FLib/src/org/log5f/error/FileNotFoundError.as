package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class FileNotFoundError extends Error
	{
		public function FileNotFoundError(file:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorFileNotFound", [file]), 2001);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}