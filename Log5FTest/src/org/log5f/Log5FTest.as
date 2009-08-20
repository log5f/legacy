package org.log5f
{
	import org.log5f.layouts.converter.CategoryConverterTest;
	import org.log5f.layouts.converter.ClassConverterTest;
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
		public var StackConverter:StackConverterTest;
		public var ClassConverter:ClassConverterTest;
		public var CategoryConverter:CategoryConverterTest;
		public var FileConverter:FileConverterTest;
		public var MethodConverter:MethodConverterTest;
		public var MessageConverter:MessageConverterTest;
		public var LevelConverter:LevelConverterTest;
		public var LineNumberConverter:LineNumberConverterTest;
	}
}