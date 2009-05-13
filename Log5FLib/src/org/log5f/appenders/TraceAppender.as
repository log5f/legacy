package org.log5f.appenders
{
	import org.log5f.IAppender;
	import org.log5f.IFilter;
	import org.log5f.ILayout;
	import org.log5f.events.LogEvent;
	
	public class TraceAppender implements IAppender
	{
		// ----------------- STATIC FIELDS ---------------- //

		
		
		// ---------------- PRIVATE FIELDS ---------------- //

		[ArrayElementType("org.log5f.IFilter")]
		private var filters:Array;
		
		private var _name:String;
		
		private var _layout:ILayout;

		// ------------------ CONSTRUCTOR ----------------- //

		public function TraceAppender()
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
			trace(this.layout.format(event));
		}

		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		

		// ------------------- HANDLERS ------------------- //

		

		// --------------- USER INTERACTION --------------- //
	}
}