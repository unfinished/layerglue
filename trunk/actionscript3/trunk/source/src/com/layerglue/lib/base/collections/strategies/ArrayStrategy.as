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
		override public function addItemAt(collection:Object, item:*, index:int):void
		{
			(collection as Array).splice(index, 0, item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItem(collection:Object, item:*):void
		{
			(collection as Array).push(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemAt(collection:Object, index:int, prefetch:int = 0):*
		{
			return (collection as Array)[index];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemIndex(collection:Object, item:*):int
		{
			return (collection as Array).indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItemAt(collection:Object, index:int):*
		{
			return (collection as Array).splice(index, 1);
		}
				
		override public function removeItem(collection:Object, item:*):*
		{
			var itemIndex:int = (collection as Array).indexOf(item);
			return (collection as Array).splice(itemIndex, 1);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAll(collection:Object):void
		{
			(collection as Array).splice(0, (collection as Array).length);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains(collection:Object, item:*):Boolean
		{
			return (collection as Array).indexOf(item) != -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getLength(collection:Object):int
		{
			return (collection as Array).length;
		}
	}
}