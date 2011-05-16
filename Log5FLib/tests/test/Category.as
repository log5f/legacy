////////////////////////////////////////////////////////////////////////////////
// Copyright 2007, Transparent Language, Inc..
// All Rights Reserved.
// Transparent Language Confidential Information
////////////////////////////////////////////////////////////////////////////////

package test
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.log5f.Category;
	import org.log5f.Level;
	import org.log5f.log5f_internal;
	
	use namespace log5f_internal;
	
	public class Category extends org.log5f.Category implements IEventDispatcher
	{
		public function Category(name:String)
		{
			super(name);
		}

		override log5f_internal function log(level:Level, message:Object, stack:String=null):void
		{
			this.dispatchEvent(new Event("log"));
		}
		
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			this.dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return this.dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return this.dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return this.dispatcher.willTrigger(type);
		}
	}
}