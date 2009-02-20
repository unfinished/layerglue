package com.layerglue.components
{
	import fl.controls.Label;
	import fl.core.UIComponent;
	
	import flash.text.AntiAliasType;

	public class LGLabel extends Label
	{
		private static var defaultStyles:Object = { antiAliasType: null }
		
		public function LGLabel()
		{
			super();
		}
		
		public static function getStyleDefinition():Object
		{ 
			return UIComponent.mergeStyles(Label.getStyleDefinition(), defaultStyles);
		}
		
		override protected function drawTextFormat():void
		{
			super.drawTextFormat();
			
			var antiAliasType:String = getStyleValue("antiAliasType") as String;
			if (antiAliasType == AntiAliasType.ADVANCED || antiAliasType == AntiAliasType.NORMAL)
			{
				textField.antiAliasType = antiAliasType;
			}
		}
		
	}
}