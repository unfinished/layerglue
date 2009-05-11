package com.layerglue.lib.base.collections.strategies
{
	
	public class ArrayStrategy extends AbstractCollectionStrategy
	{
		public function ArrayStrategy()
		{
			super();
			
			type = Array;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItemAt(collection:*, item:Object, index:int):void
		{
			(collection as Array).splice(index, 0, item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItem(collection:*, item:Object):void
		{
			(collection as Array).push(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemAt(collection:*, index:int, prefetch:int = 0):Object
		{
			return (collection as Array)[index];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemIndex(collection:*, item:Object):int
		{
			return (collection as Array).indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItemAt(collection:*, index:int):Object
		{
			return (collection as Array).splice(index, 1);
		}
				
		override public function removeItem(collection:*, item:Object):Object
		{
			var itemIndex:int = (collection as Array).indexOf(item);
			return (collection as Array).splice(itemIndex, 1);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAll(collection:*):void
		{
			(collection as Array).splice(0, (collection as Array).length);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains(collection:*, item:Object):Boolean
		{
			return (collection as Array).indexOf(item) != -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getLength(collection:*):int
		{
			return (collection as Array).length;
		}
	}
}