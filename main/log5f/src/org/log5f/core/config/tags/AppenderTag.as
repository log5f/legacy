////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.tags
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.IFactory;
	import mx.core.IMXMLObject;
	
	import org.log5f.core.IAppender;
	
	[DefaultProperty("parameters")]
	
	/**
	 * The tag that configures an appender.
	 * 
	 * <p>This class is a part of configuration Log5F from MXML.</p>
	 * 
	 * @see ConfigurationTag
	 */
	public class AppenderTag extends EventDispatcher implements IMXMLObject
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
		 * Constructor
		 */
		public function AppenderTag()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * The class name of the concrete appender.
		 */
		public var type:IFactory;
		
		[ArrayElementType("org.log5f.core.config.tags.ParameterTag")]
		/**
		 * A list of parameters that configure appender.
		 */
		public var parameters:Array;
		
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