package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class FileNotFoundError extends Error
	{
		public function FileNotFoundError(file:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorFileNotFound", [file]));
		}
	}
}