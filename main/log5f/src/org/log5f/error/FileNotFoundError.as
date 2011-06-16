package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;
	
	public class FileNotFoundError extends Error
	{
		public function FileNotFoundError(file:String)
		{
			super(ResourceManager.instance.
				getString("errorFileNotFound", [file]), 2001);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}