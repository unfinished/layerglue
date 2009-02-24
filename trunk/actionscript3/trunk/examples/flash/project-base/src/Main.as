package
{
	
	import com.client.project.io.InitialLoadManager;
	import com.client.project.locators.ModelLocator;
	import com.layerglue.components.LGBox;
	import com.layerglue.components.LGButton;
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.flash.loaders.DisplayLoader;
	
	import fl.managers.StyleManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	
	[Frame(factoryClass="com.client.project.preloader.CustomRootPreloader")]
	
	public class Main extends Sprite implements IPreloadableFlashApplication
	{
		
		private var _initialLoadManager:InitialLoadManager;
		
		private var _displayLoader:DisplayLoader;
		
		public var box:LGBox;
		public var button1:LGButton;
		public var button2:LGButton;
		
		public function Main()
		{
			super();
		}
		
		public function show(preloaderDisplay:DisplayObject):void
		{
			if(preloaderDisplay.parent && preloaderDisplay.parent.contains(preloaderDisplay))
			{
				preloaderDisplay.parent.removeChild(preloaderDisplay);
			}
			
			createChildren();
		}
		
		public function createChildren():void
		{
			drawStuff();
		}
		
		public function startInitialLoad():void
		{
			_initialLoadManager = new InitialLoadManager();
			_initialLoadManager.start();
		}
		
		private function drawStuff():void
		{
			
			StyleManager.setStyle( "textFormat", new TextFormat("RegionalFont", 12, 0x333333, false) );
			StyleManager.setStyle( "antiAliasType", AntiAliasType.ADVANCED);
			StyleManager.setStyle( "embedFonts", true );
			
			graphics.beginFill(Number(_initialLoadManager.localeConfigSource.getValueByReference("squareColor")), 1);
			graphics.drawRoundRect(100, 300, _initialLoadManager.localeConfigSource.getValueByReference("squareWidth"), _initialLoadManager.localeConfigSource.getValueByReference("squareHeight"), _initialLoadManager.localeConfigSource.getValueByReference("squareCornerRadius"), _initialLoadManager.localeConfigSource.getValueByReference("squareCornerRadius"));
			graphics.endFill();
			
		}
	}
}
