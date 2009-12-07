package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;
	
	public class DocumentInvalidError extends Error
	{
		public function DocumentInvalidError()
		{
			super(ResourceManager.instance.
				getString("errorPropertiesFileIsNotXML"), 2002);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}