package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.loaders.ILoader;
	import com.layerglue.lib.base.loaders.MultiLoader;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.layerglue.lib.base.loaders.IMeasurableLoader;
	
	/**
	 * Wraps MultiLoader to provide a convenient way to add and listen to individual loaders.
	 * This is intended to be subclassed and loaders to be added in the constructor.
	 * Processing of the loaders is begun using the start() method.
	 */
	public class ProportionalLoadManager extends EventDispatcher
	{
		private var _multiLoader:MultiLoader;
		private var _multiLoaderCompleteListener:EventListener;
		
		private var _items:Array;
		
		public function ProportionalLoadManager()
		{
			super();
			
			_items = [];
			
			_multiLoader = new MultiLoader();
			_multiLoader.pauseAfterItem = true;
			_multiLoaderCompleteListener = new EventListener(_multiLoader, Event.OPEN, openHandler);
			_multiLoaderCompleteListener = new EventListener(_multiLoader, Event.COMPLETE, completeHandler);
			
			_multiLoader.addEventListener(MultiLoaderEvent.ITEM_OPEN, itemOpenHandler);
			_multiLoader.addEventListener(MultiLoaderEvent.ITEM_CLOSE, itemCloseHandler);
			_multiLoader.addEventListener(MultiLoaderEvent.ITEM_COMPLETE, itemCompleteHandler);
			_multiLoader.addEventListener(MultiLoaderEvent.ITEM_PROGRESS, itemProgressHandler);
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
		
		/**
		 * Adds a loader item to the queue.
		 * @param loader An instance of ILoader to be added to the queue
		 * @param completeHandler The handler function to be called once the item has loaded
		 * @param errorHandler The handler function to called if the item fails to load
		 */
		public function addItem(loader:ILoader, completeHandler:Function, errorHandler:Function, proportion:Number=NaN):void
		{
			// Add loader to multiloader first, so complete event for multiloader fires before
			// here in LoadManager
			_multiLoader.addItem(loader);
			var item:LoadManagerElement = new LoadManagerElement(loader, completeHandler, errorHandler);
			_items.push(item);
		}
		
		/**
		 * Removes a loader item from the queue.
		 * @param loader A reference to the loader item to be removed
		 */
		public function removeItem(loader:ILoader):Boolean
		{
			var loadManagerElement:LoadManagerElement = getLoadManagerElementByLoader(loader);
			
			if(loadManagerElement)
			{
				loadManagerElement.destroy();
				ArrayUtils.removeItem(_items, loadManagerElement);
				return true;
			}
			
			return false;
		}
		
		/*
		* Used internally by the class to find references to loaders in the queue
		*/
		protected function getLoadManagerElementByLoader(loader:ILoader):LoadManagerElement
		{
			for each(var item:LoadManagerElement in _items)
			{
				if(item.loader == loader)
				{
					return item;
				}
			}
			return null;
		}
		/* 
		public function getProportionallyCalculatedLoadStatus():Number
		{
			for each()
			{
				
			}
		} */
		
		private function openHandler(event:Event):void
		{
			dispatchEvent(event);
		}
		
		private function completeHandler(event:Event):void
		{
			dispatchEvent(event);
		}
		
		private function itemOpenHandler(event:MultiLoaderEvent):void
		{
			dispatchEvent(event);
		}
		
		private function itemCloseHandler(event:MultiLoaderEvent):void
		{
			dispatchEvent(event);
		}
		
		private function itemCompleteHandler(event:MultiLoaderEvent):void
		{
			dispatchEvent(event);
		}
		
		private function itemProgressHandler(event:MultiLoaderEvent):void
		{
			var loader:IMeasurableLoader = (event.target as MultiLoader).currentItem as IMeasurableLoader;
			trace("proportional progress: " + loader.getBytesLoaded() + " / " + loader.getBytesTotal());
			dispatchEvent(event);
		}
			
	}
	
}

import com.layerglue.lib.base.collections.EventListenerCollection;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import com.layerglue.lib.base.loaders.ILoader;

/*
* Helper class used to encapsulate the loader and it's associated handlers.
* It creates a link between the loader complete event and the handler passed into
* the addItem() method. This means the method specified in addItem() gets called the
* moment the loader completes.
*/
class LoadManagerElement
{
	public var loader:ILoader;
	public var proportion:Number;
	private var _listenerCollection:EventListenerCollection;
	
	public function LoadManagerElement(loader:ILoader, completeHandler:Function, errorHandler:Function, proportion:Number=NaN)
	{
		this.loader = loader;
		this.proportion = proportion;
		
		_listenerCollection =  new EventListenerCollection();
		_listenerCollection.createListener(loader, Event.COMPLETE, completeHandler);
	}
	
	public function destroy():void
	{
		_listenerCollection.removeAll();
		
		loader = null;
		_listenerCollection = null;
	}
}