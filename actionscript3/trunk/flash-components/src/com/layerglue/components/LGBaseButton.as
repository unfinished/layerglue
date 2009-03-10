package com.layerglue.components
{
	import fl.controls.BaseButton;
	import fl.core.InvalidationType;

	public class LGBaseButton extends BaseButton
	{
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