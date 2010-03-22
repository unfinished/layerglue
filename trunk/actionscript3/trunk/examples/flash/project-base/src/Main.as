package
{
	import com.client.project.io.InitialLoadManager;
	import com.client.project.views.SiteView;
	import com.hydrotik.go.HydroTween;
	import com.layerglue.flash.applications.IPreloadableFlashApplication;
	import com.layerglue.flash.preloader.FlashPreloadManager;
	import com.layerglue.lib.base.resources.ImageResourceItem;
	import com.layerglue.lib.base.resources.ResourceCollection;
	import com.layerglue.lib.base.resources.SWFResourceItem;

	import mx.effects.easing.Quadratic;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

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
			
			// TESTING ONLY
			
			var imageResourceItem:ImageResourceItem = new ImageResourceItem();
			imageResourceItem.url = "flash-assets/testImage.jpg";
			imageResourceItem.proportion = 50;
			
			var swfResourceItem:SWFResourceItem = new SWFResourceItem();
			swfResourceItem.url = "flash-assets/testImage.jpg";
			swfResourceItem.proportion = 50;
			
			var rc:ResourceCollection = new ResourceCollection();
			
			rc.addItem(imageResourceItem);
			rc.addItem(swfResourceItem);
			rc.addEventListener(Event.COMPLETE, totalCompleteHandler);
			rc.start();
			
			// TESTING ONLY
		}

		private function totalCompleteHandler(event:Event) : void 
		{
			trace("Main.totalCompleteHandler: " + event.target);
			
			//var resourceCollection:ResourceCollection = event.target as ResourceCollection;
			//var item = resourceCollection.getItem("testImage");
			
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
