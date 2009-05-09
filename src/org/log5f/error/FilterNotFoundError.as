package org.log5f.error
{
	public class FilterNotFoundError extends Error
	{
		public function FilterNotFoundError(className:String)
		{
			super();
			
			this.message = "Filter '"+className+"' not found, check registration by 'LogManager.registerFilter' method."
		}
		
	}
}