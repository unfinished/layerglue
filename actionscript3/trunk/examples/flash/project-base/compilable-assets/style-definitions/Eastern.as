	package
{
	import flash.display.Sprite;
	import flash.system.Security;

	public class Eastern extends Sprite
	{
		public function Eastern()
		{
			super();
			Security.allowDomain("*");
			
			registerFonts();
		}
		
		protected function registerFonts():void
		{
			
		}
		
	}
}