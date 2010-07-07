////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.utils
{
	import flash.display.LoaderInfo;
	
	import org.log5f.Log5FConfigurator;

	/**
	 * Provides the utility methods for work with <code>LoaderInfo</code> class.
	 */
	public class LoaderInfoUtil
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static var initialized:Boolean = false;
		
		/**
		 * @private
		 */
		private static var info:LoaderInfo;
		
		/**
		 * @private
		 */
		private static var parameters:Object;

		/**
		 * @private
		 */
		private static var applicationURL:String;

		/**
		 * @private
		 */
		private static var applicationName:String;
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Retruns <code>FlashVars</code> parameters.
		 * 
		 * @return Object contained FlashVars.
		 */
		public static function getParameters():Object
		{
			if (!initialized)
				initialize();
			
			if (!parameters)
				parameters = info ? info.parameters : null;
			
			return parameters;
		}
		
		/**
		 * Returns url of application.
		 */
		public static function getApplicationURL():String
		{
			if (!initialized)
				initialize();
			
			if (!applicationURL)
				applicationURL = info ? info.url : null;
			
			return applicationURL;
		}
		
		/**
		 * Returns name of swf or html file.
		 */
		public static function getApplicationName():String
		{
			if (!initialized)
				initialize();
			
			if (!applicationName)
			{
				var url:String = getApplicationURL();
				
				if (!url)
					return null;
				
				var pattern:RegExp = /\w+(?=\.)/;
				
				var matches:Array = url.match(pattern);
				
				if (!matches || matches.length == 0)
					return null;
				
				applicationName = matches.pop();
			}
			
			return applicationName;
		}
		
		/**
		 * @private
		 */
		private static function initialize():void
		{
			try
			{
				info = LoaderInfo.getLoaderInfoByDefinition({});
			}
			catch (error:SecurityError)
			{
				if (Log5FConfigurator.traceErrors)
					trace("Log5F", error);
			}
			
			initialized = true;
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LoaderInfoUtil()
		{
			super();
		}
	}
}