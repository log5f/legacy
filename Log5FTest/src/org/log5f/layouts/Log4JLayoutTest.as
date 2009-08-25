package org.log5f.layouts
{
	import flash.display.LoaderInfo;
	
	import flexunit.framework.Assert;
	
	import org.log5f.Category;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;

	public class Log4JLayoutTest
	{
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
			
			Assert.assertEquals("", 
				'<log4j:event logger="xxx.yyy.zzz" timestamp="' + new Date().time + '" level="DEBUG" thread="' + LoaderInfo.getLoaderInfoByDefinition({}).url + '">' + 
					'<log4j:message>' + 
						'<![CDATA[' + 
							'Message' + 
						']]>' + 
					'</log4j:message>' + 
					'<log4j:locationInfo class="my.test.Test" method="my" file="C:\Labs\Log5FTest\src\my\test\Test.as" line="21"/>' + 
					'<log4j:properties>' + 
						'<log4j:data name="application" value="TestRunner" />' + 
					'</log4j:properties>' + 
				'</log4j:event>', 
				layout.format(event));
		}
		
		[Test]
		public function formatWithoutStack():void
		{
			var layout:Log4JLayout = new Log4JLayout();
			
			var event:LogEvent = new LogEvent(new Category("xxx.yyy.zzz"), Level.DEBUG, "Message");
			
			Assert.assertEquals("", 
				'<log4j:event logger="xxx.yyy.zzz" timestamp="' + new Date().time + '" level="DEBUG" thread="' + LoaderInfo.getLoaderInfoByDefinition({}).url + '">' + 
					'<log4j:message>' + 
						'<![CDATA[' + 
							'Message' + 
						']]>' + 
					'</log4j:message>' + 
					'<log4j:locationInfo class="" method="" file="" line=""/>' + 
					'<log4j:properties>' + 
						'<log4j:data name="application" value="TestRunner" />' + 
					'</log4j:properties>' + 
				'</log4j:event>', 
				layout.format(event));
		}
	}
}