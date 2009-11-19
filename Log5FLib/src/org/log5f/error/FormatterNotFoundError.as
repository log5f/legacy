package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class FormatterNotFoundError extends Error
	{
		public function FormatterNotFoundError(className:String)
		{
			super(ResourceManager.getInstance().
				getString("log", "errorFormatterNotFound", [className]), 2104);
		}
		
	}
}