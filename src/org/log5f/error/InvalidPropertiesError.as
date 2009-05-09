package org.log5f.error
{
	public class InvalidPropertiesError extends Error
	{
		public function InvalidPropertiesError(file:String)
		{
			super();
			
			this.message = "File: '"+ file +"' is not valid log5f properties file.";
		}
		
	}
}