package com.layerglue.lib.base.resources 
{
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.io.ProportionalLoadManager;

	import flash.display.DisplayObject;

	/**
	 * @author Jamie Copeland
	 */
	public class ResourceCollection extends ProportionalLoadManager 
	{
		public function ResourceCollection()
		{
			super();
		}
		
		private var _items:Array;
		public function get items():Array
		{
			return _items;
		}
		
		public function set items(value:Array):void
		{
			_items = value;
		}
		
		override protected function itemCompleteHandler(event:MultiLoaderEvent):void
		{
			super.itemCompleteHandler(event);
			
			loadNext();
		}
		
		public function getItem(id:String) : * 
		{
			return null;
		}
		
		public function getStringItem(id:String) : String 
		{
			return null;
		}
		
		public function getImageItem(id:String) : DisplayObject 
		{
			return null;
		}
		
		public function getSWFItem(id:String) : DisplayObject 
		{
			return null;
		}
		
	}
}
