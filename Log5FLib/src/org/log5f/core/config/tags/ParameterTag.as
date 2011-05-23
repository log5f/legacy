////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.tags
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.IMXMLObject;
	
	/**
	 * TODO Add comment
	 */
	public class ParameterTag extends EventDispatcher implements IMXMLObject
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
		public function ParameterTag(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * The prameter's name.
		 */
		public var name:String;

		/**
		 * The prameter's value.
		 */
		public var value:Object;
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
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