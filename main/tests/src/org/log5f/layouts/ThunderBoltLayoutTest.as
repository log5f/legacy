package org.log5f.layouts
{
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.anyOf;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.text.re;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;
	
	public class ThunderBoltLayoutTest
	{
		private var layout:ThunderBoltLayout;
		
		[Before]
		public function setUp():void
		{
			this.layout = new ThunderBoltLayout();
		}
		
		[After]
		public function tearDown():void
		{
			this.layout = null;
		}
		
		[Test]
		public function format():void
		{
			var stack:String = 
				"Error\n" +
				"	at {internal for log5f}\n" +
				"	at {internal for log5f}\n" +
				"	at org.log5f.layouts::ThunderBoltLayoutTest/format()[D:\work\t1\log5f-tests\src\org\log5f\layouts\ThunderBoltLayoutTest.as:65]\n";
			
			var lines:Array;
			
			// test simple object
			
			var o1:Object = 
				{
					"one":1,
					"two":2
				};
			
			lines = this.layout.format(new LogEvent(null, Level.INFO, ["msg", o1], stack)).split("\n");
			
			assertThat(lines.shift(), re(/info time \d+:\d+:\d+.\d+ :: org.log5f.layouts.ThunderBoltLayoutTest \[\d+\] :: msg/));
			assertThat(lines.shift(), re(/info.group \[Object\] /));
			assertThat(lines.shift(), anyOf(re(/info \[int\] one = 1/), re(/info \[int\] two = 2/))); 
			assertThat(lines.shift(), anyOf(re(/info \[int\] one = 1/), re(/info \[int\] two = 2/))); 
			assertThat(lines.shift(), re(/info.groupEnd \[Object\] /));
			
			// test nested objects
		
			var o2:Object = 
				{
					"obj":
					{
						"a":"a",
						"b":"b"
					}
				};
			
			lines = this.layout.format(new LogEvent(null, Level.INFO, ["msg", o2], stack)).split("\n");
			
			assertThat(lines.shift(), re(/info time \d+:\d+:\d+.\d+ :: org.log5f.layouts.ThunderBoltLayoutTest \[\d+\] :: msg/));
			assertThat(lines.shift(), re(/info.group \[Object\] /));
			assertThat(lines.shift(), re(/info.group \[Object\] obj/));
			assertThat(lines.shift(), anyOf(re(/info \[String\] a = a/), re(/info \[String\] b = b/))); 
			assertThat(lines.shift(), anyOf(re(/info \[String\] a = a/), re(/info \[String\] b = b/))); 
			assertThat(lines.shift(), re(/info.groupEnd \[Object\] obj/));
			assertThat(lines.shift(), re(/info.groupEnd \[Object\] /));
			
			// test array in objects
			
			var o3:Object = 
				{
					"arr":
					[
						"x", "y", "z",
					]
				};
			
			lines = this.layout.format(new LogEvent(null, Level.INFO, ["msg", o3], stack)).split("\n");
			
			assertThat(lines.shift(), re(/info time \d+:\d+:\d+.\d+ :: org.log5f.layouts.ThunderBoltLayoutTest \[\d+\] :: msg/));
			assertThat(lines.shift(), re(/info.group \[Object\] /));
			assertThat(lines.shift(), re(/info.group \[Array\] arr/));
			assertThat(lines.shift(), anyOf(re(/info \[String\] x/), re(/info \[String\] y/), re(/info \[String\] z/))); 
			assertThat(lines.shift(), anyOf(re(/info \[String\] x/), re(/info \[String\] y/), re(/info \[String\] z/))); 
			assertThat(lines.shift(), anyOf(re(/info \[String\] x/), re(/info \[String\] y/), re(/info \[String\] z/))); 
			assertThat(lines.shift(), re(/info.groupEnd \[Array\] arr/));
			assertThat(lines.shift(), re(/info.groupEnd \[Object\] /));
		}
		
		[Test]
		public function includeTime():void
		{
			var stack:String = 
				"Error\n" +
				"	at {internal for log5f}\n" +
				"	at {internal for log5f}\n" +
				"	at org.log5f.layouts::ThunderBoltLayoutTest/format()[D:\work\t1\log5f-tests\src\org\log5f\layouts\ThunderBoltLayoutTest.as:65]\n";
			
			var lines:Array;
			
			// by default includeTime is true
			
			lines = this.layout.format(new LogEvent(null, Level.INFO, ["msg"], stack)).split("\n");
			
			assertThat(lines.shift(), re(/info time \d+:\d+:\d+.\d+ :: org.log5f.layouts.ThunderBoltLayoutTest \[\d+\] :: msg/));
			
			// w/o time
			
			this.layout.includeTime = false;
			
			lines = this.layout.format(new LogEvent(null, Level.INFO, ["msg"], stack)).split("\n");
			
			assertThat(lines.shift(), re(/info org.log5f.layouts.ThunderBoltLayoutTest \[\d+\] :: msg/));
		}
		
		[Test]
		public function isStackNeeded():void
		{
			// check default value
			
			assertTrue(this.layout.isStackNeeded);
			
			// check dependency from showCaller
			
			this.layout.showCaller = false;
			
			assertFalse(this.layout.isStackNeeded);

			this.layout.showCaller = true;
			
			assertTrue(this.layout.isStackNeeded);
		}
		
		[Test]
		public function showCaller():void
		{
			var stack:String = 
				"Error\n" +
				"	at {internal for log5f}\n" +
				"	at {internal for log5f}\n" +
				"	at org.log5f.layouts::ThunderBoltLayoutTest/format()[D:\work\t1\log5f-tests\src\org\log5f\layouts\ThunderBoltLayoutTest.as:65]\n";
			
			var lines:Array;
			
			// by default showCaller is true
			
			lines = this.layout.format(new LogEvent(null, Level.INFO, ["msg"], stack)).split("\n");
			
			assertThat(lines.shift(), re(/info time \d+:\d+:\d+.\d+ :: org.log5f.layouts.ThunderBoltLayoutTest \[\d+\] :: msg/));
			
			// w/o caller information
			
			this.layout.showCaller = false;
			
			lines = this.layout.format(new LogEvent(null, Level.INFO, ["msg"], stack)).split("\n");
			
			assertThat(lines.shift(), re(/info time \d+:\d+:\d+.\d+ :: msg/));
		}
	}
}