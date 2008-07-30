package org.log5f.error
{
	public class AppenderNotFoundError extends Error
	{
		public function AppenderNotFoundError(className:String)
		{
			super();
			
			this.message = "Appender '"+className+"' not found, check registration by 'LogManager.registerAppender' method."
		}
		
	}
}