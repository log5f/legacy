package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class InvalidAppenderError extends Error
	{
		public function InvalidAppenderError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorInvalidAppender", [className]));
		}
		
	}
}