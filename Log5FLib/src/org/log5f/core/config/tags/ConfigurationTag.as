////////////////////////////////////////////////////////////////////////////////
// Copyright 2007, Transparent Language, Inc..
// All Rights Reserved.
// Transparent Language Confidential Information
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.tags
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.IMXMLObject;
	
	import org.log5f.Log5FConfigurator;
	
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
		
		[ArrayElementType("org.log5f.IAppender")]
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
			Log5FConfigurator.configure(this);
		}
	}
}