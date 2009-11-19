package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class ClassNotFoundError extends Error
	{
		public function ClassNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorClassNotFound", [className]), 2101);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}