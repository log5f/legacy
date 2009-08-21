package org.log5f.layouts
{
	import flexunit.framework.Assert;
	
	import mx.formatters.DateFormatter;
	
	import org.log5f.Category;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;

	public class PatternLayoutTest
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function PatternLayoutTest()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//  Before and After
		//
		//----------------------------------------------------------------------

		[Before]
		public function runBeforeEveryTest():void 
		{
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
		}                    

		//----------------------------------------------------------------------
		//
		//  Tests
		//
		//----------------------------------------------------------------------
		
		[Test]
		public function format():void
		{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY/MM/DD J:NN:SS";
			
			var stack:String = 
				"Error\n" +
				"	at org.log5f::Category/http://code.google.com/p/log5f::log()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:366]\n" + 
				"	at org.log5f::Category/debug()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:300]\n" +
				"	at my.test::Test/my()[C:\Labs\Log5FTest\src\my\test\Test.as:21]\n" +
				"	at my.test::Test()[C:\Labs\Log5FTest\src\my\test\Test.as:14]";
			
			var layout:PatternLayout = new PatternLayout();
			layout.conversionPattern = "%d{ABSOLUTE} [%5p] |%c{}| %C{}.%M (%F:%L) %m%n";
			
			var event:LogEvent = new LogEvent(new Category("my.test"), Level.DEBUG, "Message", stack);
			
			Assert.assertEquals("", formatter.format(new Date) + " [DEBUG] |my.test| my.test.Test.my (C:\Labs\Log5FTest\src\my\test\Test.as:21) Message\n", 
									layout.format(event));
		}
		
		[Test]
		public function formatWithoutStack():void
		{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY/MM/DD J:NN:SS";

			var formatter2:DateFormatter = new DateFormatter();
			formatter2.formatString = "YYYY/MM/DD";
			
			var layout:PatternLayout = new PatternLayout();
			layout.conversionPattern = "%d{ABSOLUTE} %d{YYYY/MM/DD} [%5p] [%1p] |%c{}| %m%n";
			
			var event:LogEvent = new LogEvent(new Category("my.test"), Level.DEBUG, "Message");
			
			Assert.assertEquals("", formatter.format(new Date) + " " + formatter2.format(new Date) + " [DEBUG] [D] |my.test| Message\n", layout.format(event));
		}
	}
}