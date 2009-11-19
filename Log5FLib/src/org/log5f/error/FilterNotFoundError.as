package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class FilterNotFoundError extends Error
	{
		public function FilterNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorFilterNotFound", [className]), 2103);
		}
		
	}
}