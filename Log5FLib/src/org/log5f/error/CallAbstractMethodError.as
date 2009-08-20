package org.log5f.error
{
	import mx.resources.ResourceManager;

	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class CallAbstractMethodError extends Error
	{
		public function CallAbstractMethodError()
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorCallAbstractmethod"));
		}
	}
}