package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.events.EventListener;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.loaders.ILoader;
	import com.layerglue.lib.base.loaders.IMeasurableLoader;
	import com.layerglue.lib.base.loaders.MultiLoader;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.layerglue.lib.base.collections.EventListenerCollection;
	
	/**
	 * Wraps MultiLoader to provide a convenient way to add and listen to individual loaders.
	 * This is intended to be subclassed and loaders to be added in the constructor.
	 * Processing of the loaders is begun using the start() method.
	 */
	public class LoadManager extends EventDispatcher
	{
		protected var _multiLoader:MultiLoader;
		
		protected var _eventListenerCollection:EventListenerCollection;
		
		protected var _items:Array;
		
		public function LoadManager()
		{
			super();
			
			totalValue = 1;
			
			_items = [];
			
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
		public function addItem(item:LoadManagerItem):void
		{
			_multiLoader.addItem(item.loader);
			_items.push(item);
		}
		
		/**
		 * Removes a loader item from the queue.
		 * @param loader A reference to the loader item to be removed
		 */
		public function removeItem(item:LoadManagerItem):Boolean
		{
			if(ArrayUtils.contains(_items, item))
			{
				//TODO Make a close method here - dont necessarily want to destroy here
				item.destroy();
				ArrayUtils.removeItem(_items, item);
				_multiLoader.removeItem(item.loader);
				return true;
			}
			
			return false;
		}
		
		private var _total:Number;
		
		public function get totalValue():Number
		{
			return _total;
		}
		
		public function set totalValue(value:Number):void
		{
			_total = value;
		}
		
		public function get currentValue():Number
		{
			return calculateCurrentValue();
		}
		
		private function calculateCurrentValue():Number
		{
			var proportionLoaded:Number = 0;;
			
			for each(var item:LoadManagerItem in _items)
			{
				if(item.loader.isComplete())
				{
					proportionLoaded += item.proportion;
				}
				else //If we get here there is still an item loading
				{
					//Get the loader contained within the item
					var measurableLoader:IMeasurableLoader = item.loader as IMeasurableLoader;
					
					//Calculate the fraction of the currently loading item's proportion
					var measurableLoaderProportion:Number = item.proportion * (measurableLoader.getBytesLoaded() / measurableLoader.getBytesTotal());
					
					//Add the fractional proportion to the overall value
					proportionLoaded += isNaN(measurableLoaderProportion) ? 0 : measurableLoaderProportion;
					
					//Make sure to stop here, as this item is loading, and all after this are
					//waiting to load
					break;
				}
			}
			
			return proportionLoaded;
		}
		
		public function fraction():Number
		{
			return currentValue / totalValue;
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
		
		/*
		* Used internally by the class to find references to loaders in the queue
		*/
		protected function getLoadManagerItemByLoader(loader:ILoader):LoadManagerItem
		{
			for each(var item:LoadManagerItem in _items)
			{
				if(item.loader == loader)
				{
					return item;
				}
			}
			return null;
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