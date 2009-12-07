package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;
	
	public class SingletonError extends Error
	{
		public function SingletonError(name:String)
		{
			super(ResourceManager.instance.
				getString("errorSingleton", [name]), 1001);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}