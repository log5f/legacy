package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class FilterNotFoundError extends Error
	{
		public function FilterNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorFilterNotFound", [className]));
		}
		
	}
}