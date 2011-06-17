package org.log5f.layouts
{
	import flexunit.framework.Assert;
	
	import mx.formatters.DateFormatter;
	
	import org.log5f.core.Category;
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
		public function formatComplex():void
		{
			var stack:String = 
				"Error\n" +
				"	at org.log5f::Category/http://code.google.com/p/log5f::log()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:366]\n" + 
				"	at org.log5f::Category/debug()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:300]\n" +
				"	at my.test::Test/my()[C:\Labs\Log5FTest\src\my\test\Test.as:21]\n" +
				"	at my.test::Test()[C:\Labs\Log5FTest\src\my\test\Test.as:14]";
			
			var event:LogEvent;
			var layout:PatternLayout = new PatternLayout();
			
			layout.conversionPattern = "[%5p] |%c{}| %C{}.%M (%F:%L) %m%n";
			event = new LogEvent(new Category("my.test"), Level.DEBUG, "Message", stack);
			Assert.assertEquals("", "[DEBUG] |my.test| my.test.Test.my (C:\Labs\Log5FTest\src\my\test\Test.as:21) Message\n", layout.format(event));
		}
		
		[Test]
		public function formatDate():void
		{
			var event:LogEvent;
			var layout:PatternLayout = new PatternLayout();
			var formatter:DateFormatter = new DateFormatter();
			
			layout.conversionPattern = "%d{ABSOLUTE}";
			formatter.formatString = "YYYY/MM/DD J:NN:SS";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", formatter.format(new Date), layout.format(event));
		}
		
		[Test]
		public function formatCategory():void
		{
			var event:LogEvent;
			var layout:PatternLayout = new PatternLayout();
			
			layout.conversionPattern = "%c{5}";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", "com.example.test.log5f", layout.format(event));
			
			layout.conversionPattern = "%c{4}";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", "com.example.test.log5f", layout.format(event));
			
			layout.conversionPattern = "%c{3}";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", "example.test.log5f", layout.format(event));
			
			layout.conversionPattern = "%c{2}";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", "test.log5f", layout.format(event));
			
			layout.conversionPattern = "%c{1}";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", "log5f", layout.format(event));
			
			layout.conversionPattern = "%c{0}";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", "com.example.test.log5f", layout.format(event));
			
			layout.conversionPattern = "%c{}";
			event = new LogEvent(new Category("com.example.test.log5f"), Level.INFO, "");
			Assert.assertEquals("", "com.example.test.log5f", layout.format(event));
		}
		
		[Test]
		public function formatPriority():void
		{
			var event:LogEvent;
			var layout:PatternLayout = new PatternLayout();
			
			layout.conversionPattern = "[%5p]";
			event = new LogEvent(new Category("my.test"), Level.INFO, "");
			Assert.assertEquals("", "[INFO ]", layout.format(event));

			layout.conversionPattern = "[%4p]";
			event = new LogEvent(new Category("my.test"), Level.INFO, "");
			Assert.assertEquals("", "[INFO]", layout.format(event));

			layout.conversionPattern = "[%3p]";
			event = new LogEvent(new Category("my.test"), Level.INFO, "");
			Assert.assertEquals("", "[INF]", layout.format(event));

			layout.conversionPattern = "[%2p]";
			event = new LogEvent(new Category("my.test"), Level.INFO, "");
			Assert.assertEquals("", "[IN]", layout.format(event));
			
			layout.conversionPattern = "[%1p]";
			event = new LogEvent(new Category("my.test"), Level.INFO, "");
			Assert.assertEquals("", "[I]", layout.format(event));
			
			layout.conversionPattern = "[%0p]";
			event = new LogEvent(new Category("my.test"), Level.INFO, "");
			Assert.assertEquals("", "[INFO]", layout.format(event));
			
			layout.conversionPattern = "[%p]";
			event = new LogEvent(new Category("my.test"), Level.INFO, "");
			Assert.assertEquals("", "[INFO]", layout.format(event));
		}
		
		[Test]
		public function formatStack():void
		{
			var stack:String = 
				"Error\n" +
				"	at org.log5f::Category/http://code.google.com/p/log5f::log()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:366]\n" + 
				"	at org.log5f::Category/debug()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:300]\n" +
				"	at my.test::Test/my()[C:\Labs\Log5FTest\src\my\test\Test.as:21]\n" +
				"	at my.test::Test()[C:\Labs\Log5FTest\src\my\test\Test.as:14]";
			
			var event:LogEvent;
			var layout:PatternLayout = new PatternLayout();
			
			// Test Class Formatting
			
			layout.conversionPattern = "%C{4}";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "my.test.Test", layout.format(event));
			
			layout.conversionPattern = "%C{3}";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "my.test.Test", layout.format(event));
			
			layout.conversionPattern = "%C{2}";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "test.Test", layout.format(event));
			
			layout.conversionPattern = "%C{1}";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "Test", layout.format(event));
			
			layout.conversionPattern = "%C{0}";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "my.test.Test", layout.format(event));
			
			layout.conversionPattern = "%C{}";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "my.test.Test", layout.format(event));
			
			// Test Method Formatting
			
			layout.conversionPattern = "%M";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "my", layout.format(event));
			
			// Test File Formatting
			
			layout.conversionPattern = "%F";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "C:\Labs\Log5FTest\src\my\test\Test.as", layout.format(event));
			
			// Test Line Number Formatting
			
			layout.conversionPattern = "%L";
			event = new LogEvent(new Category("my.test"), Level.INFO, "", stack);
			Assert.assertEquals("", "21", layout.format(event));
		}
	}
}