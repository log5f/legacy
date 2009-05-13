package org.log5f.error
{
	public class ClassNotFoundError extends Error
	{
		public function ClassNotFoundError(className:String)
		{
			super();
			
			this.message = "Could not find class '" + className + "'";
		}
		
	}
}