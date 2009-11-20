package org.log5f.demos.view.controls
{
	import flash.display.DisplayObject;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	
	import mx.graphics.RoundedRectangle;
	import mx.preloaders.DownloadProgressBar;
	
	public class Preloader extends DownloadProgressBar
	{
		//----------------------------------------------------------------------
		//
		//	Class constants
		//
		//----------------------------------------------------------------------
		
		[Embed(source="assets/images/logo.png")]
		private static const LOGO:Class;
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Preloader()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	Overridden proeprties
		//
		//----------------------------------------------------------------------
		
		override protected function get barFrameRect():RoundedRectangle
		{
			return new RoundedRectangle(14, 100, 192, 4);
		}

		override protected function get borderRect():RoundedRectangle
		{
			return new RoundedRectangle(0, 0, 220, 120, 4);
		}
		
		override protected function get labelRect():Rectangle
		{
			return new Rectangle(14, 77, 100, 16);
		}
		
		override protected function get barRect():RoundedRectangle
		{
			return new RoundedRectangle(14, 99, 192, 6, 0);
		}
		
		override public function get backgroundColor():uint
		{
			return 0x69AEE7;
		}
		
		override protected function showDisplayForDownloading(elapsedTime:int,
															  event:ProgressEvent):Boolean
		{
			return true;
		}
	
		override protected function showDisplayForInit(elapsedTime:int, 
													   count:int):Boolean
		{
			return true;
		}

		//----------------------------------------------------------------------
		//
		//	Overridden methods
		//
		//----------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var logo:DisplayObject = new LOGO();
			logo.x = (this.stageWidth - 200) >> 1;
			logo.y = (this.stageHeight - 120) >> 1;
			
			this.addChild(logo);
		}
	}
}