package com.layerglue.flex3.base.collections
{
	import com.layerglue.lib.application.events.CollectionEvent;
	import com.layerglue.lib.application.events.CollectionEventKind;
	import com.layerglue.lib.base.collections.ICollection;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * A subclass of ArrayCollection that implements the ICollection interface.
	 */
	[Bindable]
	public class FlexCollection extends ArrayCollection implements ICollection
	{
		public function FlexCollection(source:Array = null)
		{
			super(source);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getLength():int
		{
			return length;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItemAt(item:Object, index:int):void
		{
			super.addItemAt(item, index);
			
			var e:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			e.kind = CollectionEventKind.ADD;
			e.items = [item];
			e.location = index;
			dispatchEvent(e);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItem(item:Object):void
		{
			super.addItem(item);
			//Dont need to dispatch CollectionEvent here as this method calls addItemAt() which
			//dispatches it.
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItemAt(index:int):Object
		{
			var removedItem:Object = super.removeItemAt(index);
			
			if(removedItem != null)
			{
				var e:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
				e.kind = CollectionEventKind.REMOVE;
				e.items = [removedItem];
				e.location = index;
				dispatchEvent(e);
			}
			
			return removedItem;
		}
		
	}
}