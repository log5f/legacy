package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;
	
	public class ClassNotFoundError extends Error
	{
		public function ClassNotFoundError(className:String)
		{
			super(ResourceManager.instance.
				getString("errorClassNotFound", [className]), 2101);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}