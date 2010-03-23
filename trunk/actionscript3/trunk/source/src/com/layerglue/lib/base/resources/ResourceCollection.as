package com.layerglue.lib.base.resources 
{
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.io.ProportionalLoadManager;
	import com.layerglue.lib.base.io.xml.IPostDeserialize;

	/**
	 * @author Jamie Copeland
	 */
	public class ResourceCollection extends ProportionalLoadManager implements IPostDeserialize
	{
		private var _invalidateItemsFlag:Boolean;

		public function ResourceCollection()
		{
			super();
			
			_items = [];
			//_stringItems = [];
			//_imageItems = [];
			//_swfItems = [];
		}
		
		public var items2:Array;
		
		
		private var _items:Array;

		public function get items():Array
		{
			return _items;
		}

		public function set items(value:Array):void
		{
			_items = value;
		}
		
		/*
		private var _imageItems:Array;	

		public function get imageItems():Array
		{
			if(!_imageItems || _invalidateItemsFlag)
			{
				populateArrayByType(_imageItems, ImageResourceItem);
			}
			
			return _imageItems;
		}

		private var _swfItems:Array;

		public function get swfItems():Array
		{
			if(!_swfItems || _invalidateItemsFlag)
			{
				populateArrayByType(_swfItems, SWFResourceItem);
			}
			
			return _swfItems;
		}

		private var _stringItems:Array;	

		public function get stringItems():Array
		{
			if(!_stringItems || _invalidateItemsFlag)
			{
				populateArrayByType(_stringItems, StringResource);
			}
			
			return _stringItems;
		}
		
		
		private function populateArrayByType(array:Array, type:Class):void
		{
			ArrayUtils.removeAllItems(array)
			for each(var item:IResourceItem in _items)
			{
				if(item is type)
				{
					array.push(item);
				}
			}
		}

		public function getItem(id:String):*
		{
			return ArrayUtils.getItemByPropertyName(_items, "id", id);
		}

		public function getStringItem(id:String):String
		{
			return ArrayUtils.getItemByPropertyName(_stringItems, "id", id);
		}

		public function getImageItem(id:String):DisplayObject
		{
			return ArrayUtils.getItemByPropertyName(_imageItems, "id", id);
		}

		public function getSWFItem(id:String):DisplayObject
		{
			return ArrayUtils.getItemByPropertyName(_swfItems, "id", id);
		}
		*/
		override protected function itemCompleteHandler(event:MultiLoaderEvent):void
		{
			super.itemCompleteHandler(event);
			
			loadNext();
		}
		
		public function postDeserialize():void
		{
			for each(var item:IResourceItem in items)
			{
				if(item is LoadManagerToken)
				{
					addItem(item as LoadManagerToken);
					trace("ResourceCollection.postDeserialize - item: " + item);
				}
			}
		}
	}
}
