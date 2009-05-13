package org.log5f.error
{
	public class DocumentNotValidError extends Error
	{
		public function DocumentNotValidError(message:String="", id:int=0)
		{
			super(message, id);
		}
	}
}