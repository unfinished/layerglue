package
{
	import com.client.project.io.InitialLoadManager;	import com.client.project.views.SiteView;	import com.hydrotik.go.HydroTween;	import com.layerglue.flash.applications.IPreloadableFlashApplication;	import com.layerglue.flash.preloader.FlashPreloadManager;		import fl.motion.easing.Quadratic;		import flash.display.DisplayObject;	import flash.display.Sprite;	

	[Frame(factoryClass="com.client.project.preloader.CustomSWFRoot")]
	
	public class Main extends Sprite implements IPreloadableFlashApplication
	{
		
		private var _initialLoadManager:InitialLoadManager;
		private var _preloaderView:DisplayObject;
		private var _siteView:SiteView;
		
		public function Main()
		{
			super();
			
			FlashPreloadManager.getInstance().registerMainInstance(this);
		}
		
		public function show(preloaderView:DisplayObject):void
		{
			_preloaderView = preloaderView;
			
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
			
			_siteView = new SiteView();
			addChild(_siteView);
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
