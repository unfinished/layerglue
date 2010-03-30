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
		override public function addItem(collection:Object, item:*):void
		{
			collection.addItem(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItemAt(collection:Object, item:*, index:int):void
		{
			collection.addItemAt(item, index);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemAt(collection:Object, index:int, prefetch:int = 0):*
		{
			return collection.getItemAt(index, prefetch);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemIndex(collection:Object, item:*):int
		{
			return collection.getItemIndex(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItemAt(collection:Object, index:int):*
		{
			return collection.removeItemAt(index);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItem(collection:Object, item:*):*
		{
			return collection.removeItem(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAll(collection:Object):void
		{
			collection.removeAll();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains(collection:Object, item:*):Boolean
		{
			return collection.contains(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getLength(collection:Object):int
		{
			return collection.getLength();
		}
		
	}
}