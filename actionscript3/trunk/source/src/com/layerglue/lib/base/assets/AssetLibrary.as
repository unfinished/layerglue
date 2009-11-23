package com.layerglue.lib.base.assets
{
	import com.layerglue.lib.base.events.AssetLibraryEvent;
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.display.DisplayObject;
	import flash.net.getClassByAlias;
	
	public class AssetLibrary extends EventDispatcher
	{
		private var _enterFrameDispatcher:Sprite;
		private var _enterFrameListener:EventListener;
		private var _loaders:Array;
		
		public function AssetLibrary()
		{
			super();
			
			_enterFrameDispatcher = new Sprite();
			
			_loaders = [];
		}
		
		public function addLoader(loader:Loader, contentsAreEmbedded:Boolean):void
		{
			_loaders.push(loader);
			
			if(contentsAreEmbedded && !_enterFrameListener)
			{
				_enterFrameListener = new EventListener(_enterFrameDispatcher, Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			}
		}
		
		public function removeLoader(loader:Loader, unload:Boolean):void
		{
			ArrayUtils.removeItem(_loaders, loader);
			
			if(unload)
			{
				loader.unload();
			}
		}
		
		public function addEmbeddedSWF(embeddedClass:Class):void
		{
			var loader:Loader = new Loader();
			loader.loadBytes(new embeddedClass());
			addLoader(loader, true);
		}
		
		public function contains(name:String):Boolean
		{
			for each(var loader:Loader in _loaders)
			{
				var domain:ApplicationDomain = loader.contentLoaderInfo.applicationDomain;
				if(domain.hasDefinition(name))
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function getAssetClass(className:String):Class
		{
			for each(var loader:Loader in _loaders)
			{
				var domain:ApplicationDomain = loader.contentLoaderInfo.applicationDomain;
				if(domain.hasDefinition(className))
				{
					return domain.getDefinition(className) as Class;
				}
			}
			
			return null;
		}
		
		public function getAsset(className:String):DisplayObject
		{
			var classRef:Class = getAssetClass(className);
			
			if(classRef)
			{
				return new classRef();				
			}
			
			return null;
		}
		
		protected function destroyEnterFrameListener():void
		{
			if(_enterFrameListener)
			{
				_enterFrameListener.destroy();
				_enterFrameListener = null;
			}
		}
		
		public function destroy():void
		{
			destroyEnterFrameListener();
			
			for each(var loader:Loader in _loaders)
			{
				loader.unload();
			}
			
			ArrayUtils.removeAllItems(_loaders);
			
			_enterFrameDispatcher = null;
		}
		
		private function enterFrameHandler(event:Event):void
		{
			destroyEnterFrameListener();
			
			dispatchEvent(new AssetLibraryEvent(AssetLibraryEvent.EMBED_COMPLETE));
		}
	}
}