package org.log5f.error
{
	import mx.resources.ResourceManager;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ResourceBundle("log")]
	
	public class DocumentInvalidError extends Error
	{
		public function DocumentInvalidError()
		{
			super(ResourceManager.getInstance().
				getString("log", "errorPropertiesFileIsNotXML"), 2002);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}