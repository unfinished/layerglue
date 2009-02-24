package com.client.project.styles
{
	import com.layerglue.flash.styles.LGStyleCollection;
	
	import fl.managers.StyleManager;
	
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	
	public class GlobalStyle extends LGStyleCollection
	{
		
		[Embed(source="/../embedded-assets/images/layerGlueLogo.gif")]
		public static var testImage:Class;
		
		public function GlobalStyle()
		{
			super();
		}
		
		override protected function defineStyles():void
		{
			StyleManager.setStyle( "textFormat", new TextFormat("RegionalFont", 12, 0x000000, false) );
			StyleManager.setStyle( "antiAliasType", AntiAliasType.ADVANCED);
			StyleManager.setStyle( "embedFonts", true );
		}
		
		override protected function defineAssets():void
		{
			addAsset("testImage", testImage);
		}

	}
}