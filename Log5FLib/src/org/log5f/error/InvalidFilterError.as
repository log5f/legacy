package org.log5f.error
{
	public class InvalidFilterError extends Error
	{
		public function InvalidFilterError(className:String)
		{
			super();
			
			this.message = "'" + className + "' is not a valid Filter";
		}
	}
}