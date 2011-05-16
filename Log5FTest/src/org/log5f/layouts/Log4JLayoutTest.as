package org.log5f.layouts
{
	import flash.display.LoaderInfo;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.core.anyOf;
	import org.hamcrest.object.equalTo;
	import org.log5f.Category;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;

	public class Log4JLayoutTest
	{
		namespace log4j = "http://jakarta.apache.org/log4j/"; 
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function Log4JLayoutTest()
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
			var layout:Log4JLayout = new Log4JLayout();
			
			var stack:String = 
				"Error\n" +
				"	at org.log5f::Category/http://code.google.com/p/log5f::log()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:366]\n" + 
				"	at org.log5f::Category/debug()[E:\Libs\Frameworks\Log5F\Log5F\src\org\log5f\Category.as:300]\n" +
				"	at my.test::Test/my()[C:\Labs\Log5FTest\src\my\test\Test.as:21]\n" +
				"	at my.test::Test()[C:\Labs\Log5FTest\src\my\test\Test.as:14]";
			
			var event:LogEvent = new LogEvent(new Category("xxx.yyy.zzz"), Level.DEBUG, "Message", stack);
			
			use namespace log4j;
			
			var log4j:XML = new XML(layout.format(event));
			
			assertEquals("xxx.yyy.zzz", log4j.@logger);
			assertEquals(LoaderInfo.getLoaderInfoByDefinition({}).url, log4j.@thread);
			assertEquals("Message", log4j.message);
			assertEquals("my.test.Test", log4j.locationInfo.attribute("class"));
			assertEquals("my", log4j.locationInfo.@method);
			assertEquals("C:\Labs\Log5FTest\src\my\test\Test.as", log4j.locationInfo.@file);
			assertEquals("21", log4j.locationInfo.@line);
			assertEquals("application", log4j.properties.data.@name);
			assertThat(log4j.properties.data.@value, anyOf(equalTo("TestRunner"), equalTo("FlexUnitApplication")));
		}
		
		[Test]
		public function formatWithoutStack():void
		{
			var layout:Log4JLayout = new Log4JLayout();
			
			var event:LogEvent = new LogEvent(new Category("xxx.yyy.zzz"), Level.DEBUG, "Message");
			
			use namespace log4j;
			
			var log4j:XML = new XML(layout.format(event));
			
			assertEquals("xxx.yyy.zzz", log4j.@logger);
			assertEquals(LoaderInfo.getLoaderInfoByDefinition({}).url, log4j.@thread);
			assertEquals("Message", log4j.message);
			assertEquals("", log4j.locationInfo.attribute("class"));
			assertEquals("", log4j.locationInfo.@method);
			assertEquals("", log4j.locationInfo.@file);
			assertEquals("", log4j.locationInfo.@line);
			assertEquals("application", log4j.properties.data.@name);
			assertThat(log4j.properties.data.@value, anyOf(equalTo("TestRunner"), equalTo("FlexUnitApplication")));
		}
	}
}