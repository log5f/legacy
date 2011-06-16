package org.log5f.error
{
	import org.log5f.helpers.resources.ResourceManager;

	public class CallAbstractMethodError extends Error
	{
		public function CallAbstractMethodError()
		{
			super(ResourceManager.instance.
				getString("errorCallAbstractmethod"), 1002);
		}
		
		public function toString():String
		{
			return this.name + " #" + this.errorID + ": " + this.message;
		}
	}
}