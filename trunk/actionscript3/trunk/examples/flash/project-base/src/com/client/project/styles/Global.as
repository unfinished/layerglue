package com.client.project.styles
{
	import fl.managers.StyleManager;
	
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	
	public class Global
	{
		//[Embed(source="assets.jpg")]
		//public static var Asset1:Class;
		
		public function Global()
		{
			StyleManager.setStyle( "textFormat", new TextFormat("RegionalFont", 12, 0x333333, false) );
			StyleManager.setStyle( "antiAliasType", AntiAliasType.ADVANCED);
			StyleManager.setStyle( "embedFonts", true );
		}

	}
}