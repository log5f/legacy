package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class SingletonError extends Error
	{
		public function SingletonError(name:String, id:int=0)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorSingleton", [name]), id);
		}
		
	}
}