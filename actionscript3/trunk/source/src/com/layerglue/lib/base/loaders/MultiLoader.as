package com.layerglue.lib.base.loaders
{
	import com.layerglue.lib.base.collections.ArrayIterator;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	/**
	 * Enables the sequential load of multiple Iloader instances.
	 * <p>Note that since this class implements IMultiLoader which in turn implements ILoader, other
	 * MultiLoader instances can be added to create sequential multi-dimensional loaders.</p>
	 */
	public class MultiLoader extends EventDispatcher implements IMultiLoader
	{
		private var _loaders:Array;
		private var _iterator:ArrayIterator;
		
		public function MultiLoader()
		{
			super();
			
			_loaders = new Array();
			_iterator = new ArrayIterator(_loaders);
		}
		
		/**
		 * Adds an item to the end of the list of loaders. The item will only be added if it is not
		 * already present.
		 * 
		 * @param item The item to add to the loader
		 */
		public function addItem(item:ILoader):void
		{
			//TODO look into throwing error here or returning something if cant add for some reason such as already being present
			if(!ArrayUtils.contains(_loaders, item))
			{
				addListeners(item);
				ArrayUtils.addItem(_loaders, item);
			}
		}
		
		/**
		 * Adds an item at a specified position in the list of loaders. The item will only be added if it is not
		 * already present.
		 * 
		 * @param item The item to add to the loader.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:ILoader, index:uint):void
		{
			//TODO look into throwing error here or returning something if cant add for some reason such as already being present
			if(!ArrayUtils.contains(_loaders, item))
			{
				addListeners(item);
				ArrayUtils.addItemAt(_loaders, item, index);
			}
		}
		
		/**
		 * Removes an item from the list of loaders.
		 * 
		 * @param item The item to remove
		 */
		public function removeItem(item:ILoader):void
		{
			removeListeners(item);
			ArrayUtils.removeItem(_loaders, item);
		}
		
		/**
		 * Removes an item from the loaders at a specified index.
		 * 
		 * @param index The index at which to remove the item.
		 */
		public function removeItemAt(index:uint):void
		{
			if(ArrayUtils.getItemAtIndex(_loaders, index))
			{
				removeListeners(ArrayUtils.getItemAtIndex(_loaders, index) as ILoader);
				ArrayUtils.removeItemAt(_loaders, index);
			}
		}
		
		/**
		 * Removes all items from the list of loaders.
		 */
		public function removeAllItems():void
		{
			for each(var item:ILoader in _loaders)
			{
				removeItem(item);
			}
		}
		
		/**
		 * Returns an item at a specified index.
		 * 
		 * @param index The index in the list from which to retrieve the item. 
		 * 
		 * @returns An item at the specified index or null.
		 */
		public function getItemAt(index:uint):ILoader
		{
			return _loaders[index];
		}
		
		/**
		 * Returns the index of a specified item.
		 * 
		 * @param item The item to find.
		 */
		public function getItemIndex(item:ILoader):int
		{
			return ArrayUtils.getIndex(_loaders, item);
		}
		
		/**
		 * Starts the load process.
		 */
		public function open():void
		{
			dispatchEvent(new Event(Event.OPEN));
			if(currentItem && !currentItem.isComplete())
			{
				currentItem.open();
			}
			else
			{
				loadNext();
			}
		}
		
		/**
		 * Stops the load process.
		 */
		public function close():void
		{
			if(_loaders[currentIndex])
			{
				(_loaders[currentIndex] as ILoader).close();
			}
			dispatchEvent(new Event(Event.CLOSE));
		}
		
		/**
		 * @inheritDoc
		 */
		[Bindable(event="open", event="close", event="itemOpen", event="itemComplete")]
		public function isComplete():Boolean
		{
			for each(var loader:ILoader in _loaders)
			{
				if(!loader.isComplete())
				{
					return false;
				}
			}
			return true;
		}
		
		/**
		 * The index of the current item being loaded.
		 */
		[Bindable(event="open", event="close", event="itemOpen", event="itemComplete")]
		public function get currentIndex():uint
		{
			return _iterator.index;
		}
		
		/**
		 * The current item being loaded
		 */
		[Bindable(event="open", event="close", event="itemOpen", event="itemComplete")]
		public function get currentItem():ILoader
		{
			return _loaders[currentIndex];
		}
		
		/**
		 * Whether there is another item to load.
		 */
		[Bindable(event="open", event="close", event="itemOpen", event="itemComplete")]
		public function hasNext():Boolean
		{
			return _iterator.hasNext();
		}
		
		/**
		 * Starts the load of the next item, if one is present.
		 */
		public function loadNext():void
		{
			if(_iterator.hasNext())
			{
				(_iterator.next() as ILoader).open();
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private var _pauseAfterItem:Boolean;
		
		/**
		 * Whether or not the loader should pause after an item completes.
		 * @see LoadManager
		 */
		public function get pauseAfterItem():Boolean
		{
			return _pauseAfterItem;
		}
		
		public function set pauseAfterItem(value:Boolean):void
		{
			_pauseAfterItem = value;
		}
		
		private function addListeners(item:ILoader):void
		{
			item.addEventListener(Event.OPEN, itemOpenHandler, false, 0, true);
			item.addEventListener(Event.CLOSE, itemCloseHandler, false, 0, true);
			item.addEventListener(Event.COMPLETE, itemCompleteHandler, false, 0, true);
			item.addEventListener(ProgressEvent.PROGRESS, itemProgressHandler, false, 0, true);
		}
		
		private function removeListeners(item:ILoader):void
		{
			item.removeEventListener(Event.OPEN, itemOpenHandler, false);
			item.removeEventListener(Event.CLOSE, itemCloseHandler, false);
			item.removeEventListener(Event.COMPLETE, itemCompleteHandler, false);
			item.removeEventListener(ProgressEvent.PROGRESS, itemProgressHandler, false);
		}
		
		private function itemOpenHandler(event:Event):void
		{
			dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.ITEM_OPEN, (event.target as ILoader), getItemIndex((event.target as ILoader))));
		}
		
		private function itemCloseHandler(event:Event):void
		{
			dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.ITEM_CLOSE, (event.target as ILoader), getItemIndex((event.target as ILoader))));
		}
		
		private function itemCompleteHandler(event:Event):void
		{
			dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.ITEM_COMPLETE, (event.target as ILoader), getItemIndex((event.target as ILoader))));
			
			if(!pauseAfterItem)
			{
				loadNext();
			}
		}
		
		private function itemProgressHandler(event:Event):void
		{
			dispatchEvent(new MultiLoaderEvent(MultiLoaderEvent.ITEM_PROGRESS, (event.target as ILoader), getItemIndex((event.target as ILoader))));
		}
		
	}
}