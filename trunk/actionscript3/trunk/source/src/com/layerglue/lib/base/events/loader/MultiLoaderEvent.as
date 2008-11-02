package com.layerglue.lib.base.events.loader
{
	import com.layerglue.lib.base.loaders.ILoader;
	
	import flash.events.Event;
	
	/**
	 * Defines events dispatched by the MultiLoader class.
	 */
	public class MultiLoaderEvent extends Event
	{
		/**
		 * Dispatched when an item begins the load process.
		 */
		public static const ITEM_OPEN:String = "itemOpen";
		
		/**
		 * Dispatched when an item completes the load process.
		 */
		public static const ITEM_COMPLETE:String = "itemComplete";
		
		/**
		 * Dispatched when data is received during the download of an item.
		 */
		public static const ITEM_PROGRESS:String = "itemProgress";
		
		/**
		 * Dispatched when an item's load process is closed.
		 */
		public static const ITEM_CLOSE:String = "itemClose";
		
		
		private var _item:ILoader;
		
		/**
		 * The item in the MultiLoader that the event refers to.
		 */
		public function get item():ILoader
		{
			return _item;
		}
		
		public function set item(value:ILoader):void
		{
			_item = value;
		}
		
		private var _itemIndex:int;
		
		/**
		 * The index of the item in the MultiLoader that the event refers to.
		 */
		public function get itemIndex():int
		{
			return _itemIndex;
		}
		
		public function set itemIndex(value:int):void
		{
			_itemIndex = value;
		}
		
		public function MultiLoaderEvent(type:String, item:ILoader, index:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.item = item;
			this.itemIndex = index;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Duplicates this instance.
		 */
		override public function clone():Event
		{
			var e:MultiLoaderEvent = new MultiLoaderEvent(type, item, itemIndex, bubbles, cancelable);
			return e;
		}
	}
}