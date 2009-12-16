package com.layerglue.flash.controls
{
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Extension of TextField that sets up default properties and manages styles.
	 */
	public class Text extends TextField
	{
		/**
		 * When system device fonts are used this must be set to false. It will ensure the
		 * alpha property can be used on the text field.
		 */
		public static var EMBEDDED_FONTS:Boolean=true;
		
		/**
		 * Creates a new Text field object.
		 * @param style TextFormat object that is applied to the text field
		 * @param multiline Whether the text field is multiline, this affects autosizing and wordwrap
		 */
		public function Text(style:TextFormat, multiline:Boolean=false)
		{
			super();
			
			embedFonts = EMBEDDED_FONTS;
			antiAliasType = AntiAliasType.ADVANCED;
			autoSize = TextFieldAutoSize.LEFT;
			selectable = false;
			if (multiline)
			{
				this.multiline = true;
				this.wordWrap = true;
			}
			
			this.style = style; 
			
			if(!EMBEDDED_FONTS)
			{
				// Trick that bitmap-caches the text field so the alpha property works
				filters = [new GlowFilter(0xFFFFFF, 0)];
			}
		}
		
		/**
		 * The TextFormat object applied to the text field.
		 */
		public function set style(value:TextFormat):void
		{
			defaultTextFormat = value;
		}
		
		public function get style():TextFormat
		{
			return defaultTextFormat;
		}
	}
}