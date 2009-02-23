package com.layerglue.components
{
	import fl.controls.Label;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	
	import flash.text.AntiAliasType;
	
	/**
	 * LGButton adds additional functionality to the standard CS4 Label component. It can be used
	 * in exactly the same way as the original component, but supports extras features such as 
	 * anti-alias support.
	 */
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
			
			// Apply anti-aliasing to the text field.
			var antiAliasType:String = getStyleValue("antiAliasType") as String;
			if (antiAliasType == AntiAliasType.ADVANCED || antiAliasType == AntiAliasType.NORMAL)
			{
				textField.antiAliasType = antiAliasType;
			}
		}
		
		override public function invalidate(property:String=InvalidationType.ALL, callLater:Boolean=true):void
		{
			if (parent && parent is LGBox)
			{
				if (property == InvalidationType.SIZE)
				{
					// If this component is nested inside a LGBox and it's size has changed then we need
					// to invalidate the box it sits within.
					(parent as LGBox).invalidate(InvalidationType.SIZE);
				}
			}
			super.invalidate(property, callLater);
		}
		
	}
}