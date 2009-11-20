`	package
{
	import flash.system.Security;
	import flash.text.Font;
	import flash.display.Sprite;
	
	
	//TODO Look at making this extend a global style class that calls registerFonts etc
	public class Western extends Sprite
	{
		
		//[Embed(source='Swansea.ttf', fontFamily='Swansea', fontName='Swansea', fontWeight="normal", mimeType="application/x-font-truetype")]
		[Embed(source='../fonts/Swansea.ttf', fontName='RegionalFont', fontWeight="normal", mimeType="application/x-font-truetype")]
		public static var Swansea:Class;
		
		[Embed(source='../fonts/Swansea-Bold.ttf', fontName='RegionalFont', fontWeight="bold", mimeType="application/x-font-truetype")]
		public static var SwanseaBold:Class;
		
		
		public function Western()
		{
			super();
			Security.allowDomain("*");
			
			registerFonts();
		}
		
		protected function registerFonts():void
		{
			Font.registerFont(Swansea);
			Font.registerFont(SwanseaBold);
		}
		
		
	}
}