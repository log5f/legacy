////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.utils
{
	import flash.display.Loader;

	/**
	 * Contains methods to help using FlashVars.
	 */
	public class FlashvarsUtils
	{
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static var _parameters:Object;
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @return Returns object contained flash vars passed to flash 
		 * application.  
		 */
		public static function getParameters():Object
		{
			if (_parameters != null)
				return _parameters;
			
			try
			{
				var t:* = new Loader();
				
				_parameters = new Loader().loaderInfo.parameters;
			}
			catch (error:Error)
			{
				
			}
			
			return _parameters || {};
		}
	}
}