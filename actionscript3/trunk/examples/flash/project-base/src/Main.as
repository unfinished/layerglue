package
{
	
	import com.client.project.io.InitialLoadManager;
	import com.client.project.locators.ModelLocator;
	import com.client.project.styles.GlobalStyle;
	import com.layerglue.components.LGLabel;
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.flash.loaders.DisplayLoader;
	import com.layerglue.flash.styles.LGStyleManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	[Frame(factoryClass="com.client.project.preloader.CustomRootPreloader")]
	
	public class Main extends Sprite implements IPreloadableFlashApplication
	{
		
		private var _initialLoadManager:InitialLoadManager;
		
		private var _displayLoader:DisplayLoader;
		
		public function Main()
		{
			super();
			
			LGStyleManager.getInstance().registerStyle(new GlobalStyle());
		}
		
		public function show(preloaderDisplay:DisplayObject):void
		{
			if(preloaderDisplay.parent && preloaderDisplay.parent.contains(preloaderDisplay))
			{
				preloaderDisplay.parent.removeChild(preloaderDisplay);
			}
			
			trace(">>>> " + LGStyleManager.getInstance().getAsset("testImage"));
			
			var classRef:Class = LGStyleManager.getInstance().getAsset("testImage") as Class
			var im:DisplayObject = addChild(new classRef());
			im.y = 100
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
			
			var styledLabel:LGLabel = new LGLabel();
			styledLabel.text = ModelLocator.getInstance().structure.title;
			addChild(styledLabel);
			
			styledLabel.y = 30;
			
			graphics.beginFill(Number(_initialLoadManager.localeConfigSource.getValueByReference("squareColor")), 1);
			graphics.drawRoundRect(100, 300, _initialLoadManager.localeConfigSource.getValueByReference("squareWidth"), _initialLoadManager.localeConfigSource.getValueByReference("squareHeight"), _initialLoadManager.localeConfigSource.getValueByReference("squareCornerRadius"), _initialLoadManager.localeConfigSource.getValueByReference("squareCornerRadius"));
			graphics.endFill();
		}
	}
}
