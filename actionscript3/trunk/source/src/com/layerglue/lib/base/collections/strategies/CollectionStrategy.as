package com.layerglue.lib.base.collections.strategies
{
	public class CollectionStrategy extends AbstractCollectionStrategy
	{
		public function CollectionStrategy()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItem(collection:*, item:Object):void
		{
			collection.addItem(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItemAt(collection:*, item:Object, index:int):void
		{
			collection.addItemAt(item, index);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemAt(collection:*, index:int, prefetch:int = 0):Object
		{
			return collection.getItemAt(index, prefetch);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemIndex(collection:*, item:Object):int
		{
			return collection.getItemIndex(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItemAt(collection:*, index:int):Object
		{
			return collection.removeItemAt(index);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function removeItem(collection:*, item:Object):Object
		{
			return collection.removeItem(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAll(collection:*):void
		{
			collection.removeAll();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains(collection:*, item:Object):Boolean
		{
			return collection.contains(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getLength(collection:*):int
		{
			return collection.getLength();
		}
		
	}
}