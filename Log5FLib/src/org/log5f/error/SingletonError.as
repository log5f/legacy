package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class SingletonError extends Error
	{
		public function SingletonError(name:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorSingleton", [name]), 1001);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}