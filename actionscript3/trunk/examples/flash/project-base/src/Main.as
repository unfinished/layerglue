package
{
	import com.client.project.io.InitialLoadManager;	import com.client.project.styles.GlobalStyle;	import com.layerglue.flash.applications.IPreloadableFlashApplication;	import com.layerglue.flash.styles.LGStyleManager;		import flash.display.DisplayObject;	import flash.display.Sprite;
	import com.layerglue.flash.preloader.FlashPreloadManager;
	import com.hydrotik.go.HydroTween;
	import fl.motion.easing.Quadratic;
	import com.layerglue.lib.base.utils.GraphicUtils;	

	[Frame(factoryClass="com.client.project.preloader.CustomSWFRoot")]
	
	public class Main extends Sprite implements IPreloadableFlashApplication
	{
		
		private var _initialLoadManager:InitialLoadManager;
		private var _preloaderDisplay:DisplayObject;
		
		public function Main()
		{
			super();
			
			FlashPreloadManager.getInstance().registerMainInstance(this);
		}
		
		public function show(preloaderDisplay:DisplayObject):void
		{
			_preloaderDisplay = preloaderDisplay;
			
			trace("Main.show");
			if(_preloaderDisplay.parent && _preloaderDisplay.parent.contains(preloaderDisplay))
			{
				HydroTween.go(_preloaderDisplay, {alpha:0}, 2, 0, Quadratic.easeOut, preloaderHideComplete);
				
				//createChildren() and draw() are being called here, but may need to be moved in to
				//preloaderHideComplete depending on the project
				createChildren();
				draw();
			}
		}
		
		public function createChildren():void
		{
			//Create site content but hide it
			
			GraphicUtils.fillSprite(this, 0x00FF00, 1, 200, 200);
		}
		
		private function draw():void
		{
			
		}
		
		public function startInitialLoad():void
		{
			_initialLoadManager = new InitialLoadManager();
			_initialLoadManager.start();
		}
		
		private function preloaderHideComplete():void
		{
			trace("_preloaderDisplay: "+_preloaderDisplay)
			_preloaderDisplay.parent.removeChild(_preloaderDisplay);
		}
	}
}
