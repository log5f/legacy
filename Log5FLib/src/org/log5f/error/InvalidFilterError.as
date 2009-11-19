package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class InvalidFilterError extends Error
	{
		public function InvalidFilterError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorInvalidFilter", [className]), 2202);
		}
	}
}