package org.log5f.error
{
	public class FormatterNotFoundError extends Error
	{
		public function FormatterNotFoundError(className:String)
		{
			super();
			
			this.message = "Formatter '"+className+"' not found, check registration by 'LogManager.registerFormatter' method."
		}
		
	}
}