package com.client.project.controls
{
	import com.layerglue.flex3.base.controls.ThrobberImage;
	
	import flash.display.Shape;
	
	import mx.controls.Button;
	import mx.controls.Image;

	[Bindable]
	public class ThumbnailButton extends Button
	{
		private var _image:Image;
		private var _selectedBorder:Shape;
		private var _rollOverBorder:Shape;
		
		private var _imagePath:String;
		
		public function get imagePath():String
		{
			return _imagePath;
		}
		
		public function set imagePath(value:String):void
		{
			_imagePath = value;
		}
		
		public function ThumbnailButton()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_image = new Image();
			_image.source = "flash-assets/images/kew.jpg";
			_image.width = 120;
			_image.height = 120;
			addChild(_image);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
	}
}