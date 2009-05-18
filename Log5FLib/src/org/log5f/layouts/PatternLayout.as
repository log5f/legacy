package org.log5f.layouts
{
	import mx.formatters.DateFormatter;
	
	import org.log5f.ILayout;
	import org.log5f.events.LogEvent;

	public class PatternLayout implements ILayout
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		public static const DEFAULT_CONVERSION_PATTERN:String = "%m%n";
		
		//-----------------------------------
		//	Conversion patterns
		//-----------------------------------
		
		public static const CONVERSION_PATTERN_DATE:RegExp			= /%d{.*?}/;
		public static const CONVERSION_PATTERN_FILE:RegExp			= /%F/g;
		public static const CONVERSION_PATTERN_LEVEL:RegExp			= /%\d+p/;
		public static const CONVERSION_PATTERN_CLASS:RegExp			= /%C/g;
		public static const CONVERSION_PATTERN_METHOD:RegExp		= /%M/g;
		public static const CONVERSION_PATTERN_MESSAGE:RegExp		= /%m/g;
		public static const CONVERSION_PATTERN_CATEGORY:RegExp		= /%c{\d*}/;
		public static const CONVERSION_PATTERN_NEW_LINE:RegExp		= /%n/g;
		public static const CONVERSION_PATTERN_LINE_NUMBER:RegExp	= /%L/g;
		
		//-----------------------------------
		//	Helper patterns
		//-----------------------------------
		
		public static const PATTERN_CALLS:RegExp = / .+/g;
		public static const PATTERN_FILE:RegExp = /\w:\\.+as/;
		public static const PATTERN_METHOD:RegExp = /\w+\(.*\)/;
		public static const PATTERN_LINE_NUMBER:RegExp = /\d+(?=])/;
		
		
		// ---------------- PRIVATE FIELDS ---------------- //

		private var _conversionPattern:String;

		// ------------------ CONSTRUCTOR ----------------- //

		public function PatternLayout()
		{
			super();
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public function get conversionPattern():String
		{
			return this._conversionPattern || DEFAULT_CONVERSION_PATTERN;
		}

		public function set conversionPattern(value:String):void
		{
			this._conversionPattern = value;
		}

		// --------------- PROTECTED FIELDS --------------- //



		// ---------------- PUBLIC METHODS ---------------- //

		public function format(event:LogEvent):String
		{
			var result:String = this.conversionPattern;

			result = DateConverter.format(result, new Date());
			result = ClassConverter.format(result, event.category);
			result = FileConverter.format(result, event.stack);
			result = MethodConverter.format(result, event.stack);
			result = LineNumberConverter.format(result, event.stack);
			result = LevelConverter.format(result, event.level);
			result = CategoryConverter.format(result, event.category);
			result = MessageConverter.format(result, event.message);
			result = NewLineConverter.format(result, "\n");

			return result;
		}

		// --------------- PROTECTED METHODS -------------- //



		// ---------------- PRIVATE METHODS --------------- //



		// ------------------- HANDLERS ------------------- //



		// --------------- USER INTERACTION --------------- //


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

class DateConverter
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
				case DateConverter.ABSOLUTE :
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

class ClassConverter
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
		PatternLayout.CONVERSION_PATTERN_METHOD.lastIndex = 0;
		
		if (!PatternLayout.CONVERSION_PATTERN_METHOD.test(source) || !data)
			return source;
		
		var calls:Array = String(data).match(PatternLayout.PATTERN_CALLS);
		
		if (!calls && calls.length < 3)
			return source;
		
		var method:String = calls[2].match(PatternLayout.PATTERN_METHOD)[0];
		
		return source.replace(PatternLayout.CONVERSION_PATTERN_METHOD, method);
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
		PatternLayout.CONVERSION_PATTERN_LINE_NUMBER.lastIndex = 0;
		
		if (!PatternLayout.CONVERSION_PATTERN_LINE_NUMBER.test(source) || !data)
			return source;
		
		var calls:Array = String(data).match(PatternLayout.PATTERN_CALLS);
		
		if (!calls && calls.length < 3)
			return source;
		
		var line:String = calls[2].match(PatternLayout.PATTERN_LINE_NUMBER)[0];
		
		return source.replace(PatternLayout.CONVERSION_PATTERN_LINE_NUMBER, line);
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
		PatternLayout.CONVERSION_PATTERN_FILE.lastIndex = 0;
		
		if (!PatternLayout.CONVERSION_PATTERN_FILE.test(source) || !data)
			return source;
		
		var calls:Array = String(data).match(PatternLayout.PATTERN_CALLS);
		
		if (!calls && calls.length < 3)
			return source;
		
		var file:String = calls[2].match(PatternLayout.PATTERN_FILE)[0];
		
		return source.replace(PatternLayout.CONVERSION_PATTERN_FILE, file);
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
		PatternLayout.CONVERSION_PATTERN_MESSAGE.lastIndex = 0;
		
		return PatternLayout.CONVERSION_PATTERN_MESSAGE.test(source) ? 
			   source.replace(PatternLayout.CONVERSION_PATTERN_MESSAGE, data) : 
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
		PatternLayout.CONVERSION_PATTERN_NEW_LINE.lastIndex = 0;
		
		return PatternLayout.CONVERSION_PATTERN_NEW_LINE.test(source) ? 
			   source.replace(PatternLayout.CONVERSION_PATTERN_NEW_LINE, data) : 
			   source;
	}
}