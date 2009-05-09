package org.log5f.error
{
	public class FileNotFoundError extends Error
	{
		public function FileNotFoundError(file:String)
		{
			super();
			
			this.message = "File '" + file + "' not found.";
		}
	}
}