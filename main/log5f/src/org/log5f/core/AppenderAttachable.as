////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
	/**
	 * The implementation of the <code>IAppenderAttachable</code> interface.
	 */
	public class AppenderAttachable implements IAppenderAttachable
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------

		/** Constructor */
		public function AppenderAttachable()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------

		/** Storage for appenders */
		private var appenders:Array;
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------

		/** @inheritDoc */
		public function addAppender(appender:IAppender):void
		{
			if(appender == null)
				return;
				
			if(this.appenders == null)
				this.appenders = [];
				
			if(!this.isAttached(appender))
				this.appenders.push(appender);
		}
		
		/** @inheritDoc */
		public function getAllAppenders():Array
		{
			return this.appenders;
		}
		
		/** @inheritDoc */
		public function getAppender(name:String):IAppender
		{
			if(this.appenders == null || name == null)
				return null;
			
			for each(var appender:IAppender in this.appenders)
			{
				if(appender.name == name)
				{
					return appender;
				}
			}
			
			return null;
		}
		
		/** @inheritDoc */
		public function isAttached(appender:IAppender):Boolean
		{
			if(this.appenders == null || appender == null)
				return false;
			
			for each(var a:IAppender in this.appenders)
			{
				if(a == appender)
				{
					return true;
				}
			}
			
			return false;
		}
		
		/** @inheritDoc */
		public function removeAllAppenders():void
		{
			if(this.appenders != null)
			{
				for each(var appender:IAppender in this.appenders)
				{
					appender.close();
					
					appender = null;
				}
				
				this.appenders = null;
			}
		}
		
		/** @inheritDoc */
		public function removeAppender(key:Object):void
		{
			if(this.appenders == null || key == null)
				return;
			
			var appender:IAppender;
			
			if(key is IAppender)
				appender = key as IAppender;
			else if(key is String)
				appender = this.getAppender(key as String);
				
			if(appender == null)
				return;
				
			appender.close();
			
			for(var i:uint; i<this.appenders.length; i++)
			{
				if(this.appenders[i] == appender)
				{
					this.appenders[i] = null;
					this.appenders.splice(i, 1);
				}
			}
			
			if(this.appenders.length == 0)
				this.appenders = null;
			
			appender = null;
		}
	}
}