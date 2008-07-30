package org.log5f
{
	public interface IAppenderAttachable
	{
		function addAppender(appender:IAppender):void;
		function getAllAppenders():Array;
		function getAppender(name:String):IAppender;
		function isAttached(appender:IAppender):Boolean;
		function removeAllAppenders():void;
		function removeAppender(key:Object):void;
	}
}