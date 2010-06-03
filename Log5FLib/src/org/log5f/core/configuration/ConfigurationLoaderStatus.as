////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.configuration
{
	/**
	 * Defines values for <code>ConfigurationLoader.status</code> property.
	 */
	public class ConfigurationLoaderStatus
	{
		/**
		 * Defines a <code>ready</code> constant for property <code>status</code> 
		 * of the <code>ConfigurationLoader</code> class.
		 * 
		 * @see ConfigurationLoader
		 */
		public static const READY:String	= "ready";

		/**
		 * Defines a <code>loading</code> constant for property <code>status</code> 
		 * of the <code>ConfigurationLoader</code> class.
		 * 
		 * @see ConfigurationLoader
		 */
		public static const LOADING:String	= "loading";

		/**
		 * Defines a <code>success</code> constant for property <code>status</code> 
		 * of the <code>ConfigurationLoader</code> class.
		 * 
		 * @see ConfigurationLoader
		 */
		public static const SUCCESS:String	= "success";

		/**
		 * Defines a <code>failure</code> constant for property <code>status</code> 
		 * of the <code>ConfigurationLoader</code> class.
		 * 
		 * @see ConfigurationLoader
		 */
		public static const FAILURE:String	= "failure";
	}
}