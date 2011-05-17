////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.xml
{
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.object.notNullValue;
	import org.log5f.Level;
	import org.log5f.Logger;
	import org.log5f.LoggerManager;
	import org.log5f.core.config.configurators.xml.XMLConfigurator;
	
	public class XMLConfiguratorTest
	{	
		//----------------------------------------------------------------------
		//
		//	Before/After
		//
		//----------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		//----------------------------------------------------------------------
		//
		//	Tests
		//
		//----------------------------------------------------------------------
		
		[Test]
		public function configure():void
		{
			var source:XML = 
				<configuration xsi:noNamespaceSchemaLocation="log5f.properties.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:log5j="http://log5f.org">
				  <root level="ERROR" appenders="trace,firebug,xpanel"/>
				  <logger name="com.example" level="DEBUG" appenders="firebug,xpanel" />
				  <appender name="trace" class="org.log5f.appenders.TraceAppender">
				    <param name="layout" value="org.log5f.layouts.PatternLayout" type="Class">
				      <param name="conversionPattern" value="%d{ABSOLUTE} [%5p] %C{0}.%M - %m%n" type="String"/>
				    </param>
				  </appender>
				  <appender name="firebug" class="org.log5f.appenders.FirebugAppender">
				    <param name="layout" value="org.log5f.layouts.PatternLayout" type="Class">
				      <param name="conversionPattern" value="%d{ABSOLUTE} %c{1} - %m%n" type="String"/>
				    </param>
				  </appender>
				  <appender name="xpanel" class="org.log5f.appenders.XPanelAppender">
				    <param name="layout" value="org.log5f.layouts.PatternLayout" type="Class">
				      <param name="conversionPattern" value="%c{} - %m" type="String"/>
				    </param>
				  </appender>
				</configuration>;
			
			var configurator:XMLConfigurator = new XMLConfigurator();
			
			assertTrue(configurator.configure(source));
			
			var root:Logger = LoggerManager.getRootLogger();
			assertEquals(Level.ERROR, root.level);
			assertThat(root.getAppender("trace"), notNullValue());
			assertThat(root.getAppender("xpanel"), notNullValue());
			assertThat(root.getAppender("firebug"), notNullValue());
			assertTrue(root.useStack);
			
			var logger:Logger = LoggerManager.getLogger("com.example");
			assertEquals(logger.category, "com.example");
			assertEquals(Level.DEBUG, logger.level);
			assertThat(logger.getAppender("xpanel"), notNullValue());
			assertThat(logger.getAppender("firebug"), notNullValue());
			assertTrue(logger.useStack);
		}
		
		[Test]
		public function traceErrors():void
		{
			var configurator:XMLConfigurator = new XMLConfigurator();
			
			assertTrue(configurator.traceErrors);
			
			assertTrue(configurator.configure(<configuration traceErrors="true"></configuration>));

			assertTrue(configurator.traceErrors);
			
			assertTrue(configurator.configure(<configuration traceErrors="false"></configuration>));
			
			assertFalse(configurator.traceErrors);

			assertTrue(configurator.configure(<configuration traceErrors="true"></configuration>));
			
			assertTrue(configurator.traceErrors);
		}
	}
}