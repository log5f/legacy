package org.log5f
{
	import org.log5f.layouts.Log4JLayoutTest;
	import org.log5f.layouts.PatternLayoutTest;
	import org.log5f.layouts.SimpleLayoutTest;
	import org.log5f.layouts.converter.CategoryConverterTest;
	import org.log5f.layouts.converter.ClassConverterTest;
	import org.log5f.layouts.converter.DateConverterTest;
	import org.log5f.layouts.converter.FileConverterTest;
	import org.log5f.layouts.converter.LevelConverterTest;
	import org.log5f.layouts.converter.LineNumberConverterTest;
	import org.log5f.layouts.converter.MessageConverterTest;
	import org.log5f.layouts.converter.MethodConverterTest;
	import org.log5f.layouts.converter.StackConverterTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class Log5FTest
	{
		public var Log4JLayout:Log4JLayoutTest;
		public var PatternLayout:PatternLayoutTest;
		public var SimpleLayout:SimpleLayoutTest;
		
		public var StackConverter:StackConverterTest;
		public var ClassConverter:ClassConverterTest;
		public var CategoryConverter:CategoryConverterTest;
		public var FileConverter:FileConverterTest;
		public var MethodConverter:MethodConverterTest;
		public var MessageConverter:MessageConverterTest;
		public var LevelConverter:LevelConverterTest;
		public var LineNumberConverter:LineNumberConverterTest;
		public var DateConverter:DateConverterTest;
	}
}