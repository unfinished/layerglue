package com.layerglue.lib.base.collections.strategies
{
	import mx.collections.ArrayCollection;
	
	public class ArrayCollectionStrategy extends AbstractCollectionStrategy
	{
		public function ArrayCollectionStrategy()
		{
			super();
			
			type = ArrayCollection;
		}
		
		override public function addItem(collection:*, item:Object):void
		{
			(collection as ArrayCollection).addItem(item);
		}
		
		override public function getItemAt(collection:*, index:int, prefetch:int = 0):Object
		{
			return (collection as ArrayCollection).getItemAt(index, prefetch);
		}
		
		override public function getItemIndex(collection:*, item:Object):int
		{
			return (collection as ArrayCollection).getItemIndex(item);
		}
		
		//TODO look at whether or not this should throw an error as ArrayCollection does
		override public function removeItemAt(collection:*, index:int):Object
		{
			return (collection as ArrayCollection).removeItemAt(index);
		}
				
		override public function removeItem(collection:*, item:Object):Object
		{
			var itemIndex:int = (collection as ArrayCollection).getItemIndex(item);
			if(itemIndex > -1)
			{
				return (collection as ArrayCollection).removeItemAt(itemIndex);
			}
			
			return null;
		}
		
		override public function removeAll(collection:*):void
		{
			(collection as ArrayCollection).removeAll();
		}
		 
		override public function contains(collection:*, item:Object):Boolean
		{
			return (collection as ArrayCollection).contains(item);
		}
		
		override public function getLength(collection:*):int
		{
			return (collection as ArrayCollection).length;
		}
	}
}