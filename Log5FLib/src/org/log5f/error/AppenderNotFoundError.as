package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class AppenderNotFoundError extends Error
	{
		public function AppenderNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorAppenderNotFound", [className]));
		}
		
	}
}