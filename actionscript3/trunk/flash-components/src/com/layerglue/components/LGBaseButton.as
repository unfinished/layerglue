package com.layerglue.components
{
	import fl.controls.BaseButton;
	import fl.core.InvalidationType;

	public class LGBaseButton extends BaseButton
	{
		public static const UP_STATE:String = "up";
		public static const DOWN_STATE:String = "over";
		public static const OVER_STATE:String = "down";
		
		protected var _autoSizeToSkin:Boolean = true;
		
		public function LGBaseButton()
		{
			super();
			useHandCursor = true;
		}
		
		/**
		 * Convenient way of applying multiple styles to the component instance. The object should conform to the
		 * structure: {upSkin: "MyUpSkin", overSkin: "MyOverSkin", etc.}
		 * You can use both string references and direct Class references to embedded assets.
		 */
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
		
		override protected function drawBackground():void
		{
			super.drawBackground();
			
			if (_autoSizeToSkin)
			{
				_width = background.width;
				_height = background.height;
			}
		}
		
	}
}