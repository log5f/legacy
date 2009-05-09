package org.log5f.layouts
{
	import mx.formatters.DateFormatter;
	
	import org.log5f.ILayout;
	import org.log5f.events.LogEvent;
	
	public class PatternLayout implements ILayout
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const DEFAULT_CONVERSION_PATTERN:String	= "%m%n";
		
		// ---------------- PRIVATE FIELDS ---------------- //

		private var _conversionPattern:String;

		// ------------------ CONSTRUCTOR ----------------- //

		public function PatternLayout()
		{
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

class DateConverter
{
	public static const ABSOLUTE:String = "ABSOLUTE";
	
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%d{.*?}/;
	
		if(!pattern.test(source))
			return source;
		
		var matches:Array = source.match(/(?<=%d{).*?(?=})/g);
	
		var formatter:DateFormatter = new DateFormatter();
		
		for(var i:uint; i<matches.length; i++)
		{
			switch(matches[i])
			{
				case DateConverter.ABSOLUTE : 
					formatter.formatString = "YYYY/MM/DD J:NN:SS";
				break;
				default : 
					formatter.formatString = matches[i];
				break;
			}
			
			source = source.replace(pattern, formatter.format(data));
		}
		
		return source;
	}
}

class LevelConverter
{
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%\d+p/;
	
		if(!pattern.test(source))
			return source;
		
		var matches:Array = source.match(/(?<=%)\d+(?=p)/g);
	
		var level:Level = data as Level;
		var result:String;
		var count:Number;
		
		for(var i:uint; i<matches.length; i++)
		{
			result = "";
			count = parseInt(matches[i]);
			
			for(var j:uint=0; j<count; j++)
			{
				result += data.toString().charAt(j) || " ";
			}
			
			source = source.replace(pattern, result);
		}
		
		return source;
	}
}

class CategoryConverter
{
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%c{\d+}/;
	
		if(!pattern.test(source))
			return source;
		
		var matches:Array = source.match(/(?<=%c{)\d+(?=})/g);
		
		var category:Category;
		var result:String;
		var depth:Number;
		
		for(var i:uint; i<matches.length; i++)
		{
			category = data as Category;
			result = "";
			depth = parseInt(matches[i]);
			
			while(category != null && category.category != null && depth > 0)
			{
				result = category.category + "." + result;
				category = category.parent;
				depth -= 1;
			}
			
			result = result.substring(0, result.length - 1);
			
			source = source.replace(pattern, result)
		}
		
		return source;
	}
}

class MessageConverter
{
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%m/g;
		
		return pattern.test(source) ? source.replace(pattern, data) : source;
	}
}

class NewLineConverter
{
	public static function format(source:String, data:Object):String
	{
		var pattern:RegExp = /%n/g;
	
		return pattern.test(source) ? source.replace(pattern, data.toString()) : source;
	}
}