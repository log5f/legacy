package org.log5f.error
{
	import mx.resources.ResourceManager;

	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class CallAbstractMethodError extends Error
	{
		public function CallAbstractMethodError()
		{
			super(ResourceManager.getInstance().
				getString("log", "errorCallAbstractmethod"), 1002);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}