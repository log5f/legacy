////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2011 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.appenders
{
	/**
	 * This class provides backward compatibility with old configuration of
	 * Log5F, where Firebug was single appender.
	 */
	public class FirebugAppender extends BrowserAppender
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FirebugAppender()
		{
			super();
		}
	}
}