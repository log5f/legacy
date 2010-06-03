////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.configuration
{
	import flash.events.Event;
	
	import mx.core.Singleton;
	
	import org.log5f.LoggerManager;
	import org.log5f.error.InvalidConfigError;
	import org.log5f.log5f_internal;
	
	/**
	 * Configures the Log5F.
	 */
	public class Configurator
	{
		//----------------------------------------------------------------------
		//
		//	Class properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static var _impl:IConfigurator;
		
		/**
		 * @private
		 * The singleton instance of the <code>IConfigurator</code> interface.
		 */
		private static function get impl():IConfigurator
		{
			if (_impl)
			{
				_impl = Singleton.getInstance("org.log5f.core.IConfigurator") as 
					IConfigurator;
			}
			
			return _impl;
		}
		
		//-----------------------------------
		//	traceErrors
		//-----------------------------------
		
		/**
		 * A flag that indicates need to trace error messages.
		 */
		public static function get traceErrors():Boolean
		{
			return impl ? impl.traceErrors : true;
		}
		
		//-----------------------------------
		//	isConfigured
		//-----------------------------------
		
		/**
		 * @copy IConfigurator.isConfigured.
		 */
		public static function get isConfigured():Boolean
		{
			return impl && impl.isConfigured;
		}
		
		//----------------------------------------------------------------------
		//
		//	Class methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Starts configuration process.
		 */
		public static function configure():void
		{
			if (ConfigurationLoader.isLoaded)
			{
				try
				{
					impl.configure(ConfigurationLoader.data);
					
					LoggerManager.log5f_internal::processDeferredLogs();
				}
				catch (error:Error)
				{
					if (traceErrors)
						trace("Log5F:", error.getStackTrace());
				}
			}
			else
			{
				ConfigurationLoader.load();
			}
		}
		
		//-----------------------------------
		//	Class methods: EventDispatcher
		//-----------------------------------
		
		/**
		 * @copy flash.events.IEventDispatcher#addEventListener
		 */
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			impl.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#removeEventListener
		 */
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			impl.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#dispatchEvent
		 */
		public static function dispatchEvent(event:Event):Boolean
		{
			return impl.dispatchEvent(event);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#hasEventListener
		 */
		public static function hasEventListener(type:String):Boolean
		{
			return impl.hasEventListener(type);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#willTrigger
		 */
		public static function willTrigger(type:String):Boolean
		{
			return impl.willTrigger(type);
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Configurator()
		{
			super();
		}
	}
}