////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.helpers.resources
{
	import mx.resources.ResourceBundle;
	import mx.utils.StringUtil;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ExcludeClass]
	[ResourceBundle("log")]

	public class ResourceManager
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		private static const bundle:ResourceBundle;
		
		//----------------------------------------------------------------------
		//
		//	Class variables
		//
		//----------------------------------------------------------------------
		
		private static var _instance:ResourceManager;
		
		//----------------------------------------------------------------------
		//
		//	Class properties
		//
		//----------------------------------------------------------------------
		
		public static function get instance():ResourceManager
		{
			if (!ResourceManager._instance)
				ResourceManager._instance = new ResourceManager();
			
			return ResourceManager._instance;
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ResourceManager()
		{
			super();
			
			if (ResourceManager._instance)
				throw new Error("Singleton error");
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		public function getString(resource:String, parameters:Array=null):String
		{
			var string:String = String(this.getResource("getString", resource));
			
			return StringUtil.substitute(string, parameters);
		}

		public function getStringArray(resource:String):Array
		{
			return this.getResource("getStringArray", resource) as Array;
		}

		public function getNumber(resource:String):Number
		{
			return Number(this.getResource("getNumber", resource));
		}

		public function getBoolean(resource:String):Boolean
		{
			return Boolean(this.getResource("getBoolean", resource));
		}
		
		public function getObject(resource:String):Object
		{
			return this.getResource("getObject", resource);
		}
		
		private function getResource(type:String, name:String):Object
		{
			return ResourceManager.bundle[type](name);
		}
	}
}