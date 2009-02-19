package
{
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;

	public class Western extends Sprite
	{
		
		//[Embed(source='Swansea.ttf', fontFamily='Swansea', fontName='Swansea', fontWeight="normal", mimeType="application/x-font-truetype")]
		[Embed(source='Swansea.ttf', fontName='RegionalFont', fontWeight="normal", mimeType="application/x-font-truetype")]
		public static var Swansea:Class;
		
		[Embed(source='Swansea-Bold.ttf', fontName='RegionalFont', fontWeight="bold", mimeType="application/x-font-truetype")]
		public static var SwanseaBold:Class;
		
		public function Western()
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