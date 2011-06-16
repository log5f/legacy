////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts
{
	import flash.display.LoaderInfo;
	
	import mx.utils.StringUtil;
	
	import org.log5f.core.ILayout;
	import org.log5f.events.LogEvent;
	import org.log5f.helpers.resources.ResourceManager;
	import org.log5f.layouts.converters.ClassConverter;
	import org.log5f.layouts.converters.FileConverter;
	import org.log5f.layouts.converters.LineNumberConverter;
	import org.log5f.layouts.converters.MethodConverter;
	import org.log5f.utils.LoaderInfoUtil;
	
	/**
	 * Perform log event to <i>Log4J XML Format</i>.
	 * 
	 * @see http://wiki.apache.org/logging-log4j/Log4jXmlFormat Log4jXmlFormat
	 */
	public class Log4JLayout implements ILayout
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static const TEMPLATE:String = 
		'<log4j:event logger="{0}" timestamp="{1}" level="{2}" thread="{3}" xmlns:log4j="http://jakarta.apache.org/log4j/">' + 
			'<log4j:message>' + 
				'<![CDATA[' + 
					'{4}' + 
				']]>' + 
			'</log4j:message>' + 
			'<log4j:locationInfo class="{5}" method="{6}" file="{7}" line="{8}"/>' + 
			'<log4j:properties>' + 
				'<log4j:data name="application" value="{9}" />' + 
			'</log4j:properties>' + 
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
		//	Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * Returns <code>true</code>, bacause <code>Lo4JLayout</code> allways 
		 * need information from the stack.
		 * <br />
		 * @inheritDoc
		 */
		public function get isStackNeeded():Boolean
		{
			return true;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Performs log event to <i>Log4J XML Format</i>.
		 * 
		 * @param event The log event to performing.
		 * 
		 * @return Performed string in <i>Log4J XML Format</i>.
		 */
		public function format(event:LogEvent):String
		{
			var category:String = event.category.name;
			var time:String = new Date().time.toString();
			var level:String = event.level.toString();
			var thread:String = LoaderInfoUtil.getApplicationURL();
			var message:String = event.message.toString();
			var className:String = new ClassConverter().convert(event);
			var methodName:String = new MethodConverter().convert(event);
			var fileName:String = new FileConverter().convert(event);
			var lineNumber:String = new LineNumberConverter().convert(event);
			var applicationName:String = LoaderInfoUtil.getApplicationName();
			
			return StringUtil.substitute(Log4JLayout.TEMPLATE, 
										 [category, time, level, thread, 
										 message, className, methodName, 
										 fileName, lineNumber, applicationName]);
		}
	}
}