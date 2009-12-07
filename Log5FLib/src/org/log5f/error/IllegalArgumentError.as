package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;
	
	public class IllegalArgumentError extends Error
	{
		public function IllegalArgumentError(className:String)
		{
			super(ResourceManager.instance.
				getString("errorIllegalArgument", [className]), 2004);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}