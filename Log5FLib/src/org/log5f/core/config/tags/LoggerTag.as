////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.tags
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.IMXMLObject;
	import mx.core.MXMLObjectAdapter;
	
	[DefaultProperty("appenders")]
	
	/**
	 * The tag that configures a logger.
	 * 
	 * <p>This class is a part of configuration Log5F from MXML.</p>
	 * 
	 * @see ConfigurationTag
	 * @see AppenderTag
	 */
	public class LoggerTag extends EventDispatcher implements IMXMLObject
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LoggerTag()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		[Inspectable(name="category", type="Object", category="Common")]
		/**
		 * Represents a logger's name from XML configuration. 
		 * Can be <code>String</code>, <code>Class</code> or <code>Object</code>.
		 * 
		 * @see org.log5f.Logger#name Logger.name
		 */
		public var category:Object;
		
		[Inspectable(name="level", type="String", category="Common", enumeration="OFF,FATAL,ERROR,WARN,INFO,DEBUG,ALL")]
		/**
		 * Represents a loger's level.
		 * 
		 * @see org.log5f.Logger#level Logger.level 
		 */
		public var level:String;
		
		[ArrayElementType("org.log5f.core.IAppender")]
		/**
		 * The list of appenders that will be used of the logger.
		 */
		public var appenders:Array;
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Methods: IMXMLObject
		//-----------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function initialized(document:Object, id:String):void
		{
			
		}
	}
}