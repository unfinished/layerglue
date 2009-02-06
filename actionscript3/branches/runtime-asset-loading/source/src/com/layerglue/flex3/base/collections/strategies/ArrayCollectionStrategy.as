package com.layerglue.flex3.base.collections.strategies
{
	import com.layerglue.lib.base.collections.strategies.AbstractCollectionStrategy;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * An implementation of ICollectionStrategy to mediate interaction an ArrayCollection instance.
	 * 
	 * @see ICollectionStrategy
	 * @see ArrayStrategy
	 */
	public class ArrayCollectionStrategy extends AbstractCollectionStrategy
	{
		public function ArrayCollectionStrategy()
		{
			super();
			
			type = ArrayCollection;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItem(collection:*, item:Object):void
		{
			(collection as ArrayCollection).addItem(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemAt(collection:*, index:int, prefetch:int = 0):Object
		{
			return (collection as ArrayCollection).getItemAt(index, prefetch);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getItemIndex(collection:*, item:Object):int
		{
			return (collection as ArrayCollection).getItemIndex(item);
		}
		
		/**
		 * @inheritDoc
		 */
		//TODO look at whether or not this should throw an error as ArrayCollection does
		override public function removeItemAt(collection:*, index:int):Object
		{
			return (collection as ArrayCollection).removeItemAt(index);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function removeItem(collection:*, item:Object):Object
		{
			var itemIndex:int = (collection as ArrayCollection).getItemIndex(item);
			if(itemIndex > -1)
			{
				return (collection as ArrayCollection).removeItemAt(itemIndex);
			}
			
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAll(collection:*):void
		{
			(collection as ArrayCollection).removeAll();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains(collection:*, item:Object):Boolean
		{
			return (collection as ArrayCollection).contains(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getLength(collection:*):int
		{
			return (collection as ArrayCollection).length;
		}
	}
}