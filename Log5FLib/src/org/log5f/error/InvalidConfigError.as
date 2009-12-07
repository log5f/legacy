package org.log5f.error
{
	import mx.resources.IResourceManager;
	import org.log5f.helpers.resources.ResourceManager;

	public class InvalidConfigError extends Error
	{
		public function InvalidConfigError(file:String)
		{
			super(ResourceManager.instance.
				getString("errorInvalidConfig", [file]), 2002);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}