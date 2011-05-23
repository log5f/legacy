////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.tags
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.IMXMLObject;
	
	import org.log5f.core.config.Config;
	
	[DefaultProperty("objects")]
	
	/**
	 * TODO Add comment
	 */
	public class ConfigurationTag extends EventDispatcher implements IMXMLObject
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
		public function ConfigurationTag()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * A flag that indicates if Log5F's errors will throw in the console.
		 * 
		 * @default true
		 */
		public var traceErrors:Boolean = true;
		
		[ArrayElementType("org.log5f.core.IAppender")]
		[ArrayElementType("org.log5f.core.config.tags.LoggerTag")]
		/**
		 * Contains loggers and appenders.
		 */
		public var objects:Array;
		
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
			Config.configure(this);
		}
	}
}