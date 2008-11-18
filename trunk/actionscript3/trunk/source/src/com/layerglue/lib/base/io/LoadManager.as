package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.loaders.MultiLoader;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Provides a controlled way to sequentially load multiple items, with a simple callback
	 * mechanism for triggering specific methods at the completion of each item.
	 * 
	 * <pre>
		private var _loader:LoadManager;
		private var _configXML:XML;
		private var _copyXML:XML;
		
		
		private function setup()
		{
			_loadManager = new LoadManager();
		
			var configToken:LoadManagerToken = new LoadManagerToken(
				new XmlLoader(new URLRequest("flash-assets/xml/config.xml")),
				copyCompleteHandler,
				errorHandler);
			
			_loadManager.addItem(configToken);
			
			var copyToken:LoadManagerToken = new LoadManagerToken(
				new XmlLoader(new URLRequest("flash-assets/xml/copy.xml")),
				copyCompleteHandler,
				errorHandler);
			
			_loadManager.addItem(copyToken);	
			
		}
		
		private function copyCompleteHandler(event:Event):void
		{
			_configXML = (event.target as XmlLoader).data as XML;
			
			_loadManager.loadNext();
		}
		
		private function copyCompleteHandler(event:Event):void
		{
			_copyXML = (event.target as XmlLoader).data as XML;
			
			_loadManager.loadNext();
		}
	 * <pre>
	 */
	public class LoadManager extends EventDispatcher
	{
		protected var _multiLoader:MultiLoader;
		protected var _eventListenerCollection:EventListenerCollection;
		protected var _loadManagerItems:Array;
		
		public function LoadManager()
		{
			super();
			
			_loadManagerItems = [];
			
			_multiLoader = new MultiLoader();
			_multiLoader.pauseAfterItem = true;
			
			addListeners();
		}
		
		private function addListeners():void
		{
			_eventListenerCollection = new EventListenerCollection();
			_eventListenerCollection.createListener(_multiLoader, Event.OPEN, openHandler);
			_eventListenerCollection.createListener(_multiLoader, Event.COMPLETE, completeHandler);
			_eventListenerCollection.createListener(_multiLoader, MultiLoaderEvent.ITEM_OPEN, itemOpenHandler);
			_eventListenerCollection.createListener(_multiLoader, MultiLoaderEvent.ITEM_CLOSE, itemCloseHandler);
			_eventListenerCollection.createListener(_multiLoader, MultiLoaderEvent.ITEM_COMPLETE, itemCompleteHandler);
			_eventListenerCollection.createListener(_multiLoader, MultiLoaderEvent.ITEM_PROGRESS, itemProgressHandler);
		}
		
		/**
		 * Adds a loader item to the queue.
		 * @param loader An instance of ILoader to be added to the queue
		 * @param completeHandler The handler function to be called once the item has loaded
		 * @param errorHandler The handler function to called if the item fails to load
		 */
		public function addItem(item:LoadManagerToken):void
		{
			_multiLoader.addItem(item.loader);
			_loadManagerItems.push(item);
		}
		
		/**
		 * Removes a loader item from the queue.
		 * @param loader A reference to the loader item to be removed
		 */
		public function removeItem(item:LoadManagerToken):Boolean
		{
			if(ArrayUtils.contains(_loadManagerItems, item))
			{
				//TODO Make a close method here - dont necessarily want to destroy here
				item.destroy();
				ArrayUtils.removeItem(_loadManagerItems, item);
				_multiLoader.removeItem(item.loader);
				return true;
			}
			
			return false;
		}
		
		/**
		 * Starts processing the loader items in the queue. It will pause between
		 * each loader item. This allows you to do any processing you want on the
		 * result. To start loading again use the loadNext() method.
		 */
		public function start():void
		{
			_multiLoader.open();
		}
		
		/**
		 * Loads the next loader item in the queue.
		 */
		public function loadNext():void
		{
			_multiLoader.loadNext();
		}
			
		private function openHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
		private function completeHandler(event:Event):void
		{
			dispatchEvent(event.clone());
		}
		
		private function itemOpenHandler(event:MultiLoaderEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		private function itemCloseHandler(event:MultiLoaderEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		private function itemCompleteHandler(event:MultiLoaderEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		private function itemProgressHandler(event:MultiLoaderEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		public function destroy():void
		{
			_eventListenerCollection.destroy();
		}
	}
}