////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.layouts
{
	import org.log5f.layouts.converters.IConverter;
	import org.log5f.core.ILayout;
	import org.log5f.events.LogEvent;
	import org.log5f.layouts.converters.CategoryConverter;
	import org.log5f.layouts.converters.ClassConverter;
	import org.log5f.layouts.converters.DateConverter;
	import org.log5f.layouts.converters.FileConverter;
	import org.log5f.layouts.converters.LevelConverter;
	import org.log5f.layouts.converters.LineNumberConverter;
	import org.log5f.layouts.converters.MessageConverter;
	import org.log5f.layouts.converters.MethodConverter;

	/**
	 * This layout formats <code>LogEvent</code> into the string using the 
	 * <i>conversion pattern</i> - string with conversion specifier. 
	 * 
	 * <p>
	 * <b>Note</b>: The next description is mostly copied from the Log4J
	 * <a href="http://logging.apache.org/log4j/1.2/apidocs/index.html">JavaDoc</a>.
	 * </p>
	 * 
	 * <p>The <i>conversion pattern</i> is related to the Log4J's 
	 * <code>PatternLayout</code> class. A conversion pattern is composed of 
	 * literal text and format control expressions called <i>conversion 
	 * specifiers</i>.</p>
	 * 
	 * Each conversion specifier starts with a percent sign (%) and is followed 
	 * by <i>conversion character</i>. The conversion character specifies the 
	 * type of data, e.g. category, priority, date, thread name.	
	 * 
	 * <p>
	 * The recognized conversion characters are
	 * <br />
	 * 
	 * <table class="innertable">
     * <tr><th>Conversion Character</th><th>Effect</th></tr>
     * <tr>
	 * <td><b><code>c</code></b></td>
	 * <td>
	 * Used to output the category of the logging event. The category conversion 
	 * specifier can be optionally followed by <i>precision specifier</i>, that 
	 * is a decimal constant in brackets. 
	 * <br></br>
	 * If a precision specifier is given, then only the corresponding number of 
	 * right most components of the category name will be printed. By default 
	 * the category name is printed in full. 
	 * <br></br>
	 * For example, for the category name "<code>a.b.c</code>" the pattern 
	 * <b>%c{2}</b> will output "<code>b.c</code>".</td>
	 * </tr>
     * <tr>
	 * <td><b><code>C</code></b></td>
	 * <td>Used to output the fully qualified class name of the caller issuing 
	 * the logging request. This conversion specifier can be optionally followed 
	 * by precision specifier, that is a decimal constant in brackets.
	 * <br></br>
	 * If a precision specifier is given, then only the corresponding number of 
	 * right most components of the class name will be printed. By default the 
	 * class name is output in fully qualified form. 
	 * <br></br>
	 * For example, for the class name "<code>org.xyz.SomeClass</code>", the 
	 * pattern <b>%C{1}</b> will output "<code>SomeClass</code>".
	 * <br></br>
	 * <b>WARNING</b>: Generating the caller class information is slow and works
	 * only in debug version of FlashPlayer.</td>
	 * </tr>
     * <tr>
	 * <td><b><code>d</code></b></td>
	 * <td>Used to output the date of the logging event. The date conversion 
	 * specifier may be followed by a <i>date format specifier</i> enclosed 
	 * between braces.
	 * <br></br>
	 * For example, 
	 * For example, <b>%d{HH:NN:SS:Q}</b> or %d{DD MMM YYYY HH:NN:SS:Q}. 
	 * If no date format specifier is given, then <b>YYYY-MM-DD HH:NN:SS</b> 
	 * pattern is used.</td>
	 * </tr>
     * <tr>
	 * <td><b><code>F</code></b></td>
	 * <td>Used to output the file name where the logging request was issued.
	 * <br></br>
	 * <b>WARNING</b>: Generating caller location information is extremely slow 
	 * and works only in debug version of Flash Player.</td>
	 * </tr>
     * <tr>
	 * <td><b><code>L</code></b></td>
	 * <td>Used to output the line number from where the logging request was 
	 * issued.
	 * <br></br>
	 * <b>WARNING</b>: Generating caller location information is extremely slow 
	 * and works only in debug version of Flash Player.</td>
	 * </td>
	 * </tr>
     * <tr>
	 * <td><b><code>m</code></b></td>
	 * <td>Used to output the application supplied message associated with the 
	 * logging event.</td>
	 * </tr>
     * <tr>
	 * <td><b><code>M</code></b></td>
	 * <td>Used to output the method name where the logging request was issued.
	 * <br></br>
	 * <b>WARNING</b>: Generating caller location information is extremely slow 
	 * and works only in debug version of Flash Player.</td>
	 * </td>
	 * </tr>
     * <tr>
	 * <td><b><code>n</code></b></td>
	 * <td>Outputs new line character, "\n"</td>
	 * </tr>
     * <tr>
	 * <td><b><code>p</code></b></td>
	 * <td>Used to output the priority of the logging event.</td>
	 * </tr>
     * </table>
	 * 
	 * @see http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/PatternLayout.html Log4J PaternLayout
	 */
	public class PatternLayout implements ILayout
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------

		/** @private */
		private static const DEFAULT_PATTERN:String = "%m%n";
		
		//-----------------------------------
		//	Patterns for conversion characters
		//-----------------------------------
		
		/** @private */
		public static const PATTERN_DATE:RegExp			= /(?<=%d{).*?(?=})/gm;
		
		/** @private */
		public static const PATTERN_FILE:RegExp			= /%F/g;
		
		/** @private */
		public static const PATTERN_LEVEL:RegExp		= /(?<=%)\d*(?=p)/g;
		
		/** @private */
		public static const PATTERN_CLASS:RegExp		= /(?<=%C{)\d*(?=})/g;
		
		/** @private */
		public static const PATTERN_METHOD:RegExp		= /%M/g;
		
		/** @private */
		public static const PATTERN_MESSAGE:RegExp		= /%m/g;
		
		/** @private */
		public static const PATTERN_CATEGORY:RegExp		= /(?<=%c{)\d*(?=})/g;
		
		/** @private */
		public static const PATTERN_NEW_LINE:RegExp		= /%n/g;
		
		/** @private */
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
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	isStackNeeded
		//-----------------------------------
		
		/**
		 * If <code>conversionPattern</code> contains <code>%M</code>, 
		 * <code>%F</code> or <code>%L</code> this property will be 
		 * <code>true</code>, or <code>false</code> - otherwise.
		 * <br />
		 * @inheritDoc
		 */
		public function get isStackNeeded():Boolean
		{
			PatternLayout.PATTERN_FILE.lastIndex = 0;
			PatternLayout.PATTERN_METHOD.lastIndex = 0;
			PatternLayout.PATTERN_LINE_NUMBER.lastIndex = 0;
			
			var pattern:String = this.conversionPattern;
			
			return PatternLayout.PATTERN_FILE.test(pattern) || 
				PatternLayout.PATTERN_METHOD.test(pattern) || 
				PatternLayout.PATTERN_LINE_NUMBER.test(pattern);
		}
		
		//-----------------------------------
		//	conversionPattern
		//-----------------------------------
		
		/** Storage for the conversionPattern property. */
		private var _conversionPattern:String;

		/**
		 * TODO Comment property
		 */
		public function get conversionPattern():String
		{
			return this._conversionPattern || DEFAULT_PATTERN;;
		}

		/** @private */
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

		/**
		 * Converts log event to string representation using 
		 * <code>conversionPattern</code> as template.
		 * 
		 * @inheritDoc
		 */
		public function format(event:LogEvent):String
		{
			var result:String = this.conversionPattern;
			
			var i:int;
			var n:int;
			var matches:Array;
			var converter:IConverter;
			
			result = result.replace("%d{}", "%d{YYYY-MM-DD HH:NN:SS}");
			
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
				
				result = result.replace(/%\d*p/, converter.convert(event));
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