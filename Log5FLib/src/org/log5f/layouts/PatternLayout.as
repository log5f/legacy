////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts
{
	import mx.formatters.DateFormatter;
	
	import org.log5f.IConverter;
	import org.log5f.Layout;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.coverters.CategoryConverter;
	import org.log5f.layouts.coverters.ClassConverter;
	import org.log5f.layouts.coverters.DateConverter;
	import org.log5f.layouts.coverters.FileConverter;
	import org.log5f.layouts.coverters.LevelConverter;
	import org.log5f.layouts.coverters.LineNumberConverter;
	import org.log5f.layouts.coverters.MessageConverter;
	import org.log5f.layouts.coverters.MethodConverter;

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
		
		public static const PATTERN_DATE:RegExp			= /(?<=%d{).*?(?=})/g;
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
			
			var i:int;
			var n:int;
			var matches:Array;
			var converter:IConverter;
			
			matches = result.match(PATTERN_DATE);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new DateConverter(matches[i]);
				
				result = result.replace(/%d{.*?}/, converter.convert(event));
			}
			
			matches = result.match(PATTERN_LEVEL);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new LevelConverter(matches[i]);
				
				result = result.replace(/%\d+p/, converter.convert(event));
			}
			
			matches = result.match(PATTERN_MESSAGE);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new MessageConverter();
				
				result = result.replace(/%m/, converter.convert(event));
			}
			
			matches = result.match(PATTERN_CATEGORY);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new CategoryConverter(matches[i]);
				
				result = result.replace(/%c{\d*}/, converter.convert(event));
			}
			
			matches = result.match(PATTERN_NEW_LINE);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new CategoryConverter(matches[i]);
				
				result = result.replace(/%c{\d*}/, converter.convert(event));
			}
			
			matches = result.match(PATTERN_CLASS);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new ClassConverter(matches[i]);
				
				result = result.replace(/%C{\d*}/, converter.convert(event));
			}

			matches = result.match(PATTERN_METHOD);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new MethodConverter();
				
				result = result.replace(/%M/, converter.convert(event));
			}

			matches = result.match(PATTERN_FILE);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new FileConverter();
				
				result = result.replace(/%F/, converter.convert(event));
			}

			matches = result.match(PATTERN_LINE_NUMBER);
			
			n = matches.length;
			for (i = 0; i < n; i++)
			{
				converter = new LineNumberConverter();
				
				result = result.replace(/%L/, converter.convert(event));
			}
			
			result = result.replace(PATTERN_NEW_LINE, "\n");

			return result;
		}
	}
}