package org.log5f.error
{
	public class DocumentInvalidError extends Error
	{
		public function DocumentInvalidError(message:String="", id:int=0)
		{
			super(message, id);
		}
	}
}