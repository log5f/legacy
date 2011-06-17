package org.log5f.core.net
{
	import flash.net.URLRequest;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.collection.everyItem;
	import org.hamcrest.collection.hasItems;
	
	public class ConfigLoaderTest
	{
		private var loader:ConfigLoader;
		
		[Before]
		public function setUp():void
		{
			this.loader = new ConfigLoader();
		}
		
		[After]
		public function tearDown():void
		{
			this.loader = null;
		}
		
		[Test]
		public function addRequest():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_data():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function hasSpecifiedRequest():void
		{
			this.loader.predefinedRequests = [new URLRequest(), new URLRequest()];
			
			assertFalse(this.loader.hasSpecifiedRequest);
			
			this.loader.addRequest(new URLRequest());
			
			assertTrue(this.loader.hasSpecifiedRequest);
		}
		
		[Test]
		public function isPredefinedRequest():void
		{
			var r1:URLRequest = new URLRequest();
			var r2:URLRequest = new URLRequest();
			
			this.loader.predefinedRequests = [r1];
			
			this.loader.addRequest(r2);
			
			assertTrue(this.loader.isPredefinedRequest(r1));
			
			assertFalse(this.loader.isPredefinedRequest(r2));
		}
		
		[Test]
		public function load():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function predefinedRequests():void
		{
			var r1:URLRequest = new URLRequest();
			var r2:URLRequest = new URLRequest();
			
			this.loader.predefinedRequests = [r1, r2];
			
			assertThat(this.loader.predefinedRequests, hasItems(r1, r2));
			assertThat(this.loader.hasRequest(r1));
			assertThat(this.loader.hasRequest(r2));
		}
	}
}