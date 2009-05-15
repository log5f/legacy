package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class ClassNotFoundError extends Error
	{
		public function ClassNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorClassNotFound", [className]));
		}
		
	}
}