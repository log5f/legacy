////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
	import org.log5f.core.config.xml.XMLConfiguratorTest;
	import org.log5f.core.managers.DeferredManagerTest;
	import org.log5f.core.net.ConfigLoaderTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class Log5FTests
	{
		public var XMLConfigurator:XMLConfiguratorTest;
		
		public var DeferredManager:DeferredManagerTest;

		public var ConfigLoader:ConfigLoaderTest;
	}
}