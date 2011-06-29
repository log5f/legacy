////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.configurators.mxml
{
	import org.log5f.Level;
	import org.log5f.Logger;
	import org.log5f.LoggerManager;
	import org.log5f.core.IAppender;
	import org.log5f.core.config.configurators.IConfigurator;
	import org.log5f.core.config.tags.ConfigurationTag;
	import org.log5f.core.config.tags.LoggerTag;
	import org.log5f.log5f_internal;
	
	[ExcludeClass]
	
	/**
	 * The implementation of IConfigurator that configures Log5F from MXML.
	 */
	public class MXMLConfigurator implements IConfigurator
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function MXMLConfigurator()
		{
			super();
		}
		
		//-----------------------------------
		//	traceErrors
		//-----------------------------------
		
		/**
		 * @private 
		 */
		private var _traceErrors:Boolean = true;
		
		/**
		 * @inheritDoc
		 */
		public function get traceErrors():Boolean
		{
			return this._traceErrors;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Methods: IConfigurator
		//-----------------------------------
		
		public function configure(source:Object):Boolean
		{
			var configuration:ConfigurationTag = source as ConfigurationTag;
			
			if (!configuration)
				return false;
			
			for each (var tag:LoggerTag in configuration.objects)
			{
				var logger:Logger = LoggerManager.getLogger(tag.category);
				
				logger.log5f_internal::level = Level.toLevel(tag.level);
				
				for each (var appender:IAppender in tag.appenders)
				{
					logger.addAppender(appender);
				}
			}
			
			return true;
		}
		
	}
}