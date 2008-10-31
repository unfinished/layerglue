package com.layerglue.lib.base.events.loader
{
	import com.layerglue.lib.base.loaders.ILoader;
	
	import flash.events.Event;
	
	/**
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
		 * Dispatched when an item's load is closed
		 */
		public static const ITEM_CLOSE:String = "itemClose";
		
		public var item:ILoader;
		public var itemIndex:int;
		
		public function MultiLoaderEvent(type:String, item:ILoader, index:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.item = item;
			this.itemIndex = index;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var e:MultiLoaderEvent = new MultiLoaderEvent(type, item, itemIndex, bubbles, cancelable);
			return e;
		}
	}
}