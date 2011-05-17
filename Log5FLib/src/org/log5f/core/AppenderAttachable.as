package org.log5f.core
{

	public class AppenderAttachable implements IAppenderAttachable
	{
		// ----------------- STATIC FIELDS ---------------- //

		

		// ---------------- PRIVATE FIELDS ---------------- //

		private var appenders:Array;

		// ------------------ CONSTRUCTOR ----------------- //

		public function AppenderAttachable()
		{
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

		public function addAppender(appender:IAppender):void
		{
			if(appender == null)
				return;
				
			if(this.appenders == null)
				this.appenders = [];
				
			if(!this.isAttached(appender))
				this.appenders.push(appender);
		}
		
		public function getAllAppenders():Array
		{
			return this.appenders;
		}
		
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

		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		

		// --------------- USER INTERACTION --------------- //
		
	}
}