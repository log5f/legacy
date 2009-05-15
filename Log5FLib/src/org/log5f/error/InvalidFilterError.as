package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class InvalidFilterError extends Error
	{
		public function InvalidFilterError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorInvalidFilter", [className]));
		}
	}
}