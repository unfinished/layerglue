package com.layerglue.components
{
	import fl.controls.BaseButton;
	import fl.core.InvalidationType;

	public class LGBaseButton extends BaseButton
	{
		public static const UP_STATE:String = "up";
		public static const DOWN_STATE:String = "over";
		public static const OVER_STATE:String = "down";
		
		public function LGBaseButton()
		{
			super();
			useHandCursor = true;
		}
		
		public function set skinStyles(value:Object):void
		{
			var styles:Object = value;
			
			var name:String;
			for (name in styles)
			{
				//trace("setStyle> "+ name + ": " + styles[name]);
				setStyle(name, styles[name]);
			}
			
		}
		
		public function get state():String
		{
			return mouseState;
		}
		
		override protected function draw():void
		{
			if (invalidHash[InvalidationType.STATE])
			{
				//trace(mouseState);
			}
			
			super.draw();
		}
		
		override protected function drawBackground():void
		{
			super.drawBackground();
			_width = background.width;
			_height = background.height;
		}
		
	}
}