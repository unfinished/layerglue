package
{
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;

	public class Eastern extends Sprite
	{
		
		//[Embed(source='Swansea.ttf', fontFamily='Swansea', fontName='Swansea', fontWeight="normal", mimeType="application/x-font-truetype")]
		[Embed(source='../fonts/Swansea.ttf', fontName='RegionalFont', fontWeight="normal", mimeType="application/x-font-truetype")]
		public static var Swansea:Class;
		
		[Embed(source='../fonts/Swansea-Bold.ttf', fontName='RegionalFont', fontWeight="bold", mimeType="application/x-font-truetype")]
		public static var SwanseaBold:Class;
		
		public function Eastern()
		{
			super();
			Security.allowDomain("*");
			registerFonts()
		}
		
		public static function registerFonts():void
		{
			Font.registerFont(Swansea);
			Font.registerFont(SwanseaBold);
		}
		
	}
}