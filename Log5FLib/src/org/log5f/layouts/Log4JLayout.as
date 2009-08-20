////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts
{
	import mx.utils.StringUtil;
	
	import org.log5f.Layout;
	import org.log5f.events.LogEvent;
	
	public class Log4JLayout extends Layout
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		private static var template:String = 
		'<log4j:event logger="{0}" timestamp="{1}" level="{2}" thread="{3}">' + 
			'<log4j:message>' + 
				'<![CDATA[' + 
					'{4}' + 
				']]>' + 
			'</log4j:message>' + 
			'<log4j:locationInfo class="{5}" method="{6}" file="{7}" line="{8}"/>' + 
		'</log4j:event>';
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Log4JLayout()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		override public function format(event:LogEvent):String
		{
			var category:String = event.category.name;
			var time:String = new Date().time.toString();
			var level:String = event.level.toString();
			var thread:String = "";
			var message:String = event.message.toString();
			
			return StringUtil.substitute(Log4JLayout.template, 
										 [category, time, level, thread, message]);
		}
	}
}