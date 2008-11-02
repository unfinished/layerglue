package com.layerglue.flex3.base.controls
{
	import flash.display.MovieClip;
	
	import mx.core.UIComponent;

	public class Throbber extends UIComponent
	{
		protected var _preloaderAnim:MovieClip;
		
		public function Throbber()
		{
			super();
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var preloaderClass:Class = getStyle("throbberGraphic");
			_preloaderAnim = new preloaderClass() as MovieClip;
			width = _preloaderAnim.width;
			height = _preloaderAnim.height;
			addChild(_preloaderAnim);
		} 
	}
}