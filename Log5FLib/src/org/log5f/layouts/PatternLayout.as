////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts
{
	import mx.formatters.DateFormatter;
	
	import org.log5f.Layout;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.coverters.ClassConverter;
	import org.log5f.layouts.coverters.DateConverter;

	public class PatternLayout extends Layout
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		public static const DEFAULT_PATTERN:String = "%m%n";
		
		//-----------------------------------
		//	Conversion patterns
		//-----------------------------------
		
		public static const PATTERN_DATE:RegExp			= /(?<=%d{).*?(?=})/;
		public static const PATTERN_FILE:RegExp			= /%F/g;
		public static const PATTERN_LEVEL:RegExp		= /(?<=%)\d+(?=p)/g;
		public static const PATTERN_CLASS:RegExp		= /(?<=%C{)\d*(?=})/g;
		public static const PATTERN_METHOD:RegExp		= /%M/g;
		public static const PATTERN_MESSAGE:RegExp		= /%m/g;
		public static const PATTERN_CATEGORY:RegExp		= /(?<=%c{)\d*(?=})/g;
		public static const PATTERN_NEW_LINE:RegExp		= /%n/g;
		public static const PATTERN_LINE_NUMBER:RegExp	= /%L/g;
		
		//-----------------------------------
		//	Helper patterns
		//-----------------------------------
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/**
		 * Constructor.
		 */
		public function PatternLayout()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden properties
		//
		//----------------------------------------------------------------------
		
		override public function get isStackNeeded():Boolean
		{
			PatternLayout.PATTERN_FILE.lastIndex = 0;
			PatternLayout.PATTERN_METHOD.lastIndex = 0;
			PatternLayout.PATTERN_LINE_NUMBER.lastIndex = 0;
			
			var pattern:String = this.conversionPattern;
			
			return PatternLayout.PATTERN_FILE.test(pattern) || 
				   PatternLayout.PATTERN_METHOD.test(pattern) || 
				   PatternLayout.PATTERN_LINE_NUMBER.test(pattern);
		}
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	conversionPattern
		//-----------------------------------
		
		/**
		 * @private
		 * Storage for the conversionPattern property.
		 */
		private var _conversionPattern:String;

		/**
		 * TODO Comment property
		 */
		public function get conversionPattern():String
		{
			return this._conversionPattern || DEFAULT_PATTERN;;
		}

		/**
		 * @private
		 */
		public function set conversionPattern(value:String):void
		{
			if (value === this._conversionPattern)
				return;
			
			this._conversionPattern = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------

		override public function format(event:LogEvent):String
		{
			var result:String = this.conversionPattern;
			
//			// reset patterns
//			
//			PATTERN_DATE.lastIndex = 0;
//			PATTERN_FILE.lastIndex = 0;
//			PATTERN_LEVEL.lastIndex = 0;
//			PATTERN_CLASS.lastIndex = 0;
//			PATTERN_METHOD.lastIndex = 0;
//			PATTERN_MESSAGE.lastIndex = 0;
//			PATTERN_CATEGORY.lastIndex = 0;
//			PATTERN_NEW_LINE.lastIndex = 0;
//			PATTERN_LINE_NUMBER.lastIndex = 0;
//			
//			// current value after converting
//			
//			var value:String;
//			
//			// current converter
//			
//			var converter:IConverter;
//			
//			// date
//			
//			if (PATTERN_DATE.test(result))
//			{
//				converter = new DateConverter();
//			
//				for each (var format:String in result.match(PATTERN_DATE))
//				{
//					value = converter.convert(event, format);
//					
//					result = result.replace("%d{" + format + "}", value);
//				}
//			}
//			
//			// level (priority)
//			
//			if (PATTERN_LEVEL.test(result))
//			{
//				converter = new LevelConverter();
//				
//				value = converter.convert(event);
//				
//				for each (var p:String in result.match(PATTERN_DATE))
//				{
//					result = result.replace("%p{" + p + "}", value.substr(parseInt(p)));
//				}
//			}
//			
//			// category
//			
//			if (PATTERN_CATEGORY.test(result))
//			{
//				converter = new CategoryConverter();
//				
//				value = converter.convert(event);
//				
//				for each (var c:String in result.match(PATTERN_DATE))
//				{
//					result = result.replace("%c{" + c + "}", value.substr(parseInt(c)));
//				}
//			}
//			
//			// message
//			
//			if (PATTERN_MESSAGE.test(result))
//			{
//				result = result.replace(PATTERN_MESSAGE, 
//										new MessageConverter().convert(event));
//			}
			
			for each (var d:String in result.match(PATTERN_CLASS))
			{
				result = result.replace("%C{" + d + "}", 
										new ClassConverter(parseInt(d)).convert(event));
			}
			
			
			result = DateConverter2.format(result, new Date());
			result = ClassConverter2.format(result, event.category);
			result = FileConverter.format(result, event.stack);
			result = MethodConverter.format(result, event.stack);
			result = LineNumberConverter.format(result, event.stack);
			result = LevelConverter.format(result, event.level);
			result = CategoryConverter.format(result, event.category);
			result = MessageConverter.format(result, event.message);
			result = NewLineConverter.format(result, "\n");

			return result;
		}
	}
}

import mx.formatters.DateFormatter;
import org.log5f.layouts.PatternLayout;
import org.log5f.Category;
import org.log5f.LoggerManager;
import org.log5f.Level;

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: DateConverter
//
////////////////////////////////////////////////////////////////////////////////

class DateConverter2
{
	public static const ABSOLUTE:String = "ABSOLUTE";

	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%d{.*?}/;

		if (!pattern.test(source))
			return source;

		var matches:Array = source.match(/(?<=%d{).*?(?=})/g);

		var formatter:DateFormatter = new DateFormatter();

		for (var i:uint; i < matches.length; i++)
		{
			switch (matches[i])
			{
				case DateConverter2.ABSOLUTE :
				{
					formatter.formatString = "YYYY/MM/DD J:NN:SS";
					break;
				}
				
				default :
				{
					formatter.formatString = matches[i];
					break;
				}
			}

			source = source.replace(pattern, formatter.format(data));
		}

		return source;
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: LevelConverter
//
////////////////////////////////////////////////////////////////////////////////

class LevelConverter
{
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%\d+p/;

		if (!pattern.test(source))
			return source;

		var matches:Array = source.match(/(?<=%)\d+(?=p)/g);

		var level:Level = data as Level;
		var result:String;
		var count:Number;

		for (var i:uint; i < matches.length; i++)
		{
			result = "";
			count = parseInt(matches[i]);

			for (var j:uint = 0; j < count; j++)
			{
				result += data.toString().charAt(j) || " ";
			}

			source = source.replace(pattern, result);
		}

		return source;
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: CategoryConverter
//
////////////////////////////////////////////////////////////////////////////////

class CategoryConverter
{
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%c{\d*}/;

		if (!pattern.test(source))
			return source;

		var matches:Array = source.match(/(?<=%c{)\d*(?=})/g);

		var n:int = matches.length;

		for (var i:int = 0; i < n; i++)
		{
			var depth:int = parseInt(matches[i]);

			var categories:Array = Category(data).name.split(".");

			var startIndex:int = depth > 0 ? Math.max(0, categories.length - depth - 1) : 0;

			var endIndex:int = Math.max(0, categories.length - 1);

			var result:String = categories.slice(startIndex, endIndex).join(".");

			source = source.replace(pattern, result);
		}

		return source;
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: ClassConverter
//
////////////////////////////////////////////////////////////////////////////////

class ClassConverter2
{
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%C{\d*}/;

		if (!pattern.test(source))
			return source;

		var matches:Array = source.match(/(?<=%C{)\d*(?=})/g);

		var n:int = matches.length;

		for (var i:int = 0; i < n; i++)
		{
			var depth:int = parseInt(matches[i]);

			var categories:Array = Category(data).name.split(".");

			var startIndex:int = depth > 0 ? Math.max(0, categories.length - depth) : 0;

			var endIndex:int = Math.max(0, categories.length);

			var result:String = categories.slice(startIndex, endIndex).join(".");

			source = source.replace(pattern, result);
		}

		return source;
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: MethodConverter
//
////////////////////////////////////////////////////////////////////////////////

class MethodConverter
{
	public static function format(source:String, data:Object):String
	{
		PatternLayout.PATTERN_METHOD.lastIndex = 0;
		
		if (!PatternLayout.PATTERN_METHOD.test(source) || !data)
			return source;
		
		var calls:Array = String(data).match(/ .+/g);
		
		if (!calls && calls.length < 3)
			return source;
		
		var method:String = calls[2].match(/\w+\(.*\)/)[0];
		
		return source.replace(PatternLayout.PATTERN_METHOD, method);
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: LineNumberConverter
//
////////////////////////////////////////////////////////////////////////////////

class LineNumberConverter
{
	public static function format(source:String, data:Object):String
	{
		PatternLayout.PATTERN_LINE_NUMBER.lastIndex = 0;
		
		if (!PatternLayout.PATTERN_LINE_NUMBER.test(source) || !data)
			return source;
		
		var calls:Array = String(data).match(/ .+/g);
		
		if (!calls && calls.length < 3)
			return source;
		
		var line:String = calls[2].match(/\d+(?=])/)[0];
		
		return source.replace(PatternLayout.PATTERN_LINE_NUMBER, line);
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: FileConverter
//
////////////////////////////////////////////////////////////////////////////////

class FileConverter
{
	public static function format(source:String, data:Object):String
	{
		PatternLayout.PATTERN_FILE.lastIndex = 0;
		
		if (!PatternLayout.PATTERN_FILE.test(source) || !data)
			return source;
		
		var calls:Array = String(data).match(/ .+/g);
		
		if (!calls && calls.length < 3)
			return source;
		
		var file:String = calls[2].match(/\w:\\.+as/)[0];
		
		return source.replace(PatternLayout.PATTERN_FILE, file);
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: MessageConverter
//
////////////////////////////////////////////////////////////////////////////////

class MessageConverter
{
	public static function format(source:String, data:Object):String
	{
		PatternLayout.PATTERN_MESSAGE.lastIndex = 0;
		
		return PatternLayout.PATTERN_MESSAGE.test(source) ? 
			   source.replace(PatternLayout.PATTERN_MESSAGE, data) : 
			   source;
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//	Helper classes: NewLineConverter
//
////////////////////////////////////////////////////////////////////////////////

class NewLineConverter
{
	public static function format(source:String, data:Object):String
	{
		PatternLayout.PATTERN_NEW_LINE.lastIndex = 0;
		
		return PatternLayout.PATTERN_NEW_LINE.test(source) ? 
			   source.replace(PatternLayout.PATTERN_NEW_LINE, data) : 
			   source;
	}
}