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
		private var _preloaderView:DisplayObject;
		
		public function Main()
		{
			super();
			
			FlashPreloadManager.getInstance().registerMainInstance(this);
		}
		
		public function show(preloaderView:DisplayObject):void
		{
			_preloaderView = preloaderView;
			
			trace("Main.show");
			if(_preloaderView.parent && _preloaderView.parent.contains(_preloaderView))
			{
				HydroTween.go(_preloaderView, {alpha:0}, 2, 0, Quadratic.easeOut, preloaderHideComplete);
				
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
			_preloaderView.parent.removeChild(_preloaderView);
		}
	}
}
