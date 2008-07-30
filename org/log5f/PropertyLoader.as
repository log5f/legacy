package org.log5f
{
	import org.log5f.error.DocumentNotValidError;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class PropertyLoader
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const FILE:String = "log5f.properties";
		
		private static var request:URLRequest = new URLRequest(FILE);
		
		private static var loader:URLLoader = new URLLoader();

		private static var loaded:Boolean = false;

		// ---------------- PRIVATE FIELDS ---------------- //



		// ------------------ CONSTRUCTOR ----------------- //

		public function PropertyLoader()
		{
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

		public static function load():void
		{
			if(!loaded)
			{
				loaded = true;
				
				loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
				
				loader.load(request);
			}
		}

		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		protected static function loaderCompleteHandler(event:Event):void
		{
			var properties:XML = new XML((event.target as URLLoader).data);
			
			if(properties is XML)
				PropertyConfigurator.configure(properties);
			else
				throw new DocumentNotValidError("Properties file is not xml.");
		}
		
		protected static function loaderIOErrorHandler(event:IOErrorEvent):void
		{
			trace("PropertyLoader.loaderIOErrorHandler");
			
			loaded = false;
			
			throw new IOError(event.text);
		}
		
		protected static function loaderSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("PropertyLoader.loaderSecurityErrorHandler");
			
			loaded = false;
			
			throw new SecurityError(event.text);
		}

		// --------------- USER INTERACTION --------------- //

	}
}