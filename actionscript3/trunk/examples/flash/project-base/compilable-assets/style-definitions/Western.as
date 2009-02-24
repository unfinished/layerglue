	package
{
	import com.layerglue.flash.styles.LGStyleCollection;
	
	import fl.managers.StyleManager;
	
	import flash.system.Security;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextFormat;

	public class Western extends LGStyleCollection
	{
		
		//[Embed(source='Swansea.ttf', fontFamily='Swansea', fontName='Swansea', fontWeight="normal", mimeType="application/x-font-truetype")]
		[Embed(source='../fonts/Swansea.ttf', fontName='RegionalFont', fontWeight="normal", mimeType="application/x-font-truetype")]
		public static var Swansea:Class;
		
		[Embed(source='../fonts/Swansea-Bold.ttf', fontName='RegionalFont', fontWeight="bold", mimeType="application/x-font-truetype")]
		public static var SwanseaBold:Class;
		
		[Embed(source="../images/penguins.jpg")]
		public static var testImage:Class;
		
		public function Western()
		{
			super();
			Security.allowDomain("*");
		}
		
		override protected function registerFonts():void
		{
			Font.registerFont(Swansea);
			Font.registerFont(SwanseaBold);
		}
		
		override protected function defineStyles():void
		{
			StyleManager.setStyle( "textFormat", new TextFormat("RegionalFont", 12, 0x00FF00, false) );
			StyleManager.setStyle( "antiAliasType", AntiAliasType.ADVANCED);
			StyleManager.setStyle( "embedFonts", true );
		}
		
		override protected function defineAssets():void
		{
			addAsset("testImage", testImage);
		}
		
	}
}