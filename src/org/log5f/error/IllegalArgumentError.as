package org.log5f.error
{
	public class IllegalArgumentError extends Error
	{
		public function IllegalArgumentError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}