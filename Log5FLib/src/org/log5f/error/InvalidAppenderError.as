package org.log5f.error
{
	public class InvalidAppenderError extends Error
	{
		public function InvalidAppenderError(className:String)
		{
			super();
			
			this.message = "'" + className + "' is not a valid Appender";
		}
		
	}
}