package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBoundle("log5f")]
	
	public class FormatterNotFoundError extends Error
	{
		public function FormatterNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log5f", "errorFormatterNotFound", [className]));
		}
		
	}
}