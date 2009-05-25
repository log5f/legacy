package org.log5f.appenders
{
	import flash.external.ExternalInterface;
	
	import org.log5f.IAppender;
	import org.log5f.ILayout;
	import org.log5f.Level;
	import org.log5f.events.LogEvent;

	public class FirebugAppender implements IAppender
	{
		// ----------------- STATIC FIELDS ---------------- //

		

		// ---------------- PRIVATE FIELDS ---------------- //

		[ArrayElementType("org.log5f.IFilter")]
		private var filters:Array;
		
		private var _name:String;
		
		private var _layout:ILayout;

		// ------------------ CONSTRUCTOR ----------------- //

		public function FirebugAppender()
		{
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public function get name():String
		{
			return this._name;
		}
		
		public function set name(value:String):void
		{
			this._name = value;
		}
		
		public function get layout():ILayout
		{
			return this._layout;
		}
		
		public function set layout(value:ILayout):void
		{
			this._layout = value;
		}

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

		public function close():void
		{
			this.layout = null;
		}
		
		public function doAppend(event:LogEvent):void
		{
			if (!ExternalInterface.available)
				return;
			
			var method:String;
			
			switch (event.level.toInt())
			{
				case Level.ALL.toInt() : 
				{
					method = "function(message){try{console.log(message);}catch(e){}}";
					
					break;
				}
				
				case Level.DEBUG.toInt() :
				{
					method = "function(message){try{console.debug(message);}catch(e){}}";
					
					break;
				}
				
				case Level.INFO.toInt() : 
				{
					method = "function(message){try{console.info(message);}catch(e){}}";
					
					break;
				}
				
				case Level.WARN.toInt() : 
				{
					method = "function(message){try{console.warn(message);}catch(e){}}";
					
					break;
				}
				
				case Level.ERROR.toInt() :
				{
					method = "function(message){try{console.error(message);}catch(e){}}"; 
					
					break;
				} 
				
				case Level.FATAL.toInt() : 
				{
					method = "function(message){try{console.error(message);}catch(e){}}";

					break;
				}
				
				case Level.OFF.toInt() : 
				default :
				{
					break;
				}
			}
			
			ExternalInterface.call(method, this.layout.format(event));
			
		}
		
		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		

		// --------------- USER INTERACTION --------------- //

		
	}
}