﻿package com.layerglue.components{	import fl.controls.Button;	import fl.core.InvalidationType;	import fl.core.UIComponent;		import flash.text.AntiAliasType;	import flash.text.TextFieldAutoSize;		/**	 * LGButton adds additional functionality to the standard CS4 Button component. It can be used	 * in exactly the same way as the original component, but supports extras features such as 	 * anti-alias support and auto-sizing of based on label length.	 */	public class LGLabelButton extends Button implements ILGComponent	{		private static var defaultStyles:Object = { antiAliasType: null, textHeightPadding: 0 }		public function LGLabelButton()		{			super();			useHandCursor = true;		}				protected var _autoSize:Boolean = false;		/**		 * Sets the automatic sizing of the button based on the label length. If true the button		 * width will match the label width, if false the label will be truncated if it's		 * wider than the button. Defaults to false.		 */		public function get autoSize():Boolean		{			return _autoSize;		}				public function set autoSize(value:Boolean):void		{			_autoSize = value;			if (value == true)			{				textField.autoSize = TextFieldAutoSize.LEFT;			}			else			{				textField.autoSize = TextFieldAutoSize.NONE;			}			invalidate(InvalidationType.SIZE);		}				/**		 * Convenient way of applying multiple styles to the component instance. The object should conform to the		 * structure: {upSkin: "MyUpSkin", overSkin: "MyOverSkin", etc.}		 * You can use both string references and direct Class references to embedded assets.		 */		public function set skinStyles(value:Object):void		{			var styles:Object = value;						var name:String;			for (name in styles)			{				//trace("setStyle> "+ name + ": " + styles[name]);				setStyle(name, styles[name]);			}		}				public static function getStyleDefinition():Object		{ 			return UIComponent.mergeStyles(Button.getStyleDefinition(), defaultStyles);		}				override protected function drawTextFormat():void		{			super.drawTextFormat();						// Apply anti-aliasing to the text field.			var antiAliasType:String = getStyleValue("antiAliasType") as String;			if (antiAliasType == AntiAliasType.ADVANCED || antiAliasType == AntiAliasType.NORMAL)			{				textField.antiAliasType = antiAliasType;			}		}				override protected function drawLayout():void		{			super.drawLayout();						if (autoSize)			{				// Calculate new width of button based on text field size				var txtPad:Number = Number(getStyleValue("textPadding"));				var newWidth:Number = txtPad + textField.width + txtPad;				_width = newWidth;								var txtHeightPadding:Number = Number(getStyleValue("textHeightPadding"));				var newHeight:Number = txtHeightPadding + textField.height + txtHeightPadding;				_height = newHeight;								// Re-layout the text field and background skin based on the new width				super.drawLayout();								// Horrible hack to make a tiny adjustment to the text position. I think the Gill Sans font is not reporting textWidth correctly and throwing calculations off.				textField.x -= 1;			}		}				override public function invalidate(property:String=InvalidationType.ALL, callLater:Boolean=true):void		{			if (parent && parent is LGBox)			{				if (property == InvalidationType.SIZE)				{					// If this component is nested inside a LGBox and it's size has changed then we need					// to invalidate the box it sits within.					(parent as LGBox).invalidate(InvalidationType.SIZE);				}			}			super.invalidate(property, callLater);		}			}}