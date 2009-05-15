package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class InvalidConfigError extends Error
	{
		public function InvalidConfigError(file:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorInvalidConfig", [file]));
		}
		
	}
}