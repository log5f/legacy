////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts
{
	import flash.utils.describeType;
	
	import org.log5f.core.ILayout;
	import org.log5f.events.LogEvent;
	import org.log5f.helpers.formatters.DateFormatter;
	import org.log5f.layouts.converters.CategoryConverter;
	import org.log5f.layouts.converters.ClassConverter;
	import org.log5f.layouts.converters.LineNumberConverter;
	
	/**
	 * This layout formats event objects into form that is recoginzible for 
	 * ThunderBolt AS3 Console.
	 * 
	 * <b>Note</b>: this class has a <u>draft</u> status.
	 * 
	 * @see http://code.google.com/p/flash-thunderbolt/ ThunderBolt Home Page
	 */
	public class ThunderBoltLayout implements ILayout
	{
		private static const GROUP_START: String = "group";
		private static const GROUP_END: String = "groupEnd";
		private static const TIME: String = "time";
		private static const FIELD_SEPERATOR: String = " :: ";
		private static const MAX_DEPTH: int = 255;
		
		public function ThunderBoltLayout()
		{
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		/** @private */
		private var depth:uint;
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	isStackNeeded
		//-----------------------------------
		
		/** @inheritDoc */
		public function get isStackNeeded():Boolean
		{
			return this.showCaller;
		}
		
		//-----------------------------------
		//	includeTime
		//-----------------------------------
		
		private var _includeTime:Boolean = true;

		public function get includeTime():Boolean
		{
			return _includeTime;
		}

		public function set includeTime(value:Boolean):void
		{
			_includeTime = value;
		}
		
		//-----------------------------------
		//	showCaller
		//-----------------------------------
		
		private var _showCaller:Boolean = true;

		public function get showCaller():Boolean
		{
			return _showCaller;
		}

		public function set showCaller(value:Boolean):void
		{
			_showCaller = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Methods: ILayout
		//-----------------------------------
		
		/** @inheritDoc */
		public function format(event:LogEvent):String
		{
			return this.log(event);
		}
		
		//-----------------------------------
		//	Methods: Internal
		//-----------------------------------
		
		/** @private */
		private function log(event:LogEvent):String
		{
			this.depth = 0;
			
			var logMsg:String = event.level.toString().toLowerCase() + " ";
			
			if (this.includeTime)
			{
				var formatter:DateFormatter = new DateFormatter();
				formatter.formatString = "HH:MM:SS.Q";
				
				logMsg += TIME + " " + formatter.format(new Date()) + FIELD_SEPERATOR;
			}
			
			if (this.showCaller)
			{
				var cls:String = new ClassConverter().convert(event);
				var ln:String = new LineNumberConverter().convert(event);
				
				logMsg += cls + " [" + ln + "]" + FIELD_SEPERATOR;
			}
			
			var msg:String;
			var logObjects:Array;
			
			if (event.message is String)
			{
				msg = event.message as String;
			}
			else if (event.message is Array && event.message.length > 0)
			{
				msg = event.message.shift() as String;
				
				logObjects = event.message as Array;
			}
			
			logMsg += msg || "";
			
			logMsg += "\n";
			
			if (logObjects)
			{
				var n:int = logObjects.length;	 	
				for (var i:int = 0; i < n; i++) 
				{
					logMsg += logObject(event, logObjects[i]);
				}					
			}
			
			return logMsg;
		}
		
		private function logObject(event:LogEvent, logObj:Object, id:String=null):String
		{
			var result:String = "";
			
			if (depth >= MAX_DEPTH)
				return "STOP LOGGING: More than " + depth + " nested objects or properties.";
				
			++ depth;
			
			var propID: String = id || "";
			var description:XML = describeType(logObj);				
			var type: String = description.@name;
			
			if (primitiveType(type))
			{					
				return (propID.length) 	? 	
					event.level.toString().toLowerCase() + " " + "[" + type + "] " + propID + " = " + logObj :
					event.level.toString().toLowerCase() + " " + "[" + type + "] " + logObj;
			}
			else if (type == "Object")
			{
				result += event.level.toString().toLowerCase() + "." + GROUP_START + " " + "[Object] " + propID + "\n";
				
				for (var element:String in logObj)
				{
					result += logObject(event, logObj[element], element) + "\n";	
				}
				
				result +=  event.level.toString().toLowerCase() + "." + GROUP_END + " " + "[Object] " + propID;
			}
			else if (type == "Array")
			{
				result += event.level.toString().toLowerCase() + "." + GROUP_START + " " + "[Array] " + propID + "\n";
				
				var i: int = 0, max: int = logObj.length;					  					  	
				for (i; i < max; i++)
				{
					result += logObject(event, logObj[i]) + "\n";
				}
				
				result +=  event.level.toString().toLowerCase() + "." + GROUP_END + " " + "[Array] " + propID;
			}
			else
			{
				// log private props as well - thx to Rob Herman [http://www.toolsbydesign.com]
				var list: XMLList = description..accessor;					
				
				if (list.length())
				{
					for each(var item: XML in list)
					{
						var propItem: String = item.@name;
						var typeItem: String = item.@type;							
						var access: String = item.@access;
						
						// log objects && properties accessing "readwrite" and "readonly" only 
						if (access && access != "writeonly") 
						{
							//TODO: filter classes
							// var classReference: Class = getDefinitionByName(typeItem) as Class;
							var valueItem: * = logObj[propItem];
							result += logObject(event, valueItem, propItem) + "\n";
						}
					}					
				}
				else
				{
					result += logObject(event, logObj, type) + "\n";					
				}
			}
			
			return result;
		}
		
		private static function primitiveType (type: String): Boolean
		{
			var isPrimitiveType: Boolean;
			
			switch (type) 
			{
				case "Boolean":
				case "void":
				case "int":
				case "uint":
				case "Number":
				case "String":
				case "undefined":
				case "null":
					isPrimitiveType = true;
					break;			
				default:
					isPrimitiveType = false;
			}
			
			return isPrimitiveType;
		}
	}
}