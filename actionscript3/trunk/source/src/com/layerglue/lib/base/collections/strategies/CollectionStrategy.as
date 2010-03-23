package com.layerglue.lib.base.collections.strategies
{
	import com.layerglue.lib.base.collections.ICollection;

	public class CollectionStrategy extends AbstractCollectionStrategy
	{
		public function CollectionStrategy()
		{
			super();
		}

		/**
		 * @inheritDoc
		 */
		override public function addItem(collection : *, item : Object) : void
		{
			(collection as ICollection).addItem(item);
		}

		/**
		 * @inheritDoc
		 */
		override public function addItemAt(collection : *, item : Object, index : int) : void
		{
			(collection as ICollection).addItemAt(item, index);
		}

		/**
		 * @inheritDoc
		 */
		override public function getItemAt(collection : *, index : int, prefetch : int = 0) : Object
		{
			return (collection as ICollection).getItemAt(index, prefetch);
		}

		/**
		 * @inheritDoc
		 */
		override public function getItemIndex(collection : *, item : Object) : int
		{
			return (collection as ICollection).getItemIndex(item);
		}

		/**
		 * @inheritDoc
		 */
		override public function removeItemAt(collection : *, index : int) : Object
		{
			return (collection as ICollection).removeItemAt(index);
		}

		/**
		 * @inheritDoc
		 */	
		override public function removeItem(collection : *, item : Object) : Object
		{
			return (collection as ICollection).removeItem(item);
		}

		/**
		 * @inheritDoc
		 */
		override public function removeAll(collection : *) : void
		{
			(collection as ICollection).removeAll();
		}

		/**
		 * @inheritDoc
		 */
		override public function contains(collection : *, item : Object) : Boolean
		{
			return (collection as ICollection).contains(item);
		}

		/**
		 * @inheritDoc
		 */
		override public function getLength(collection : *) : int
		{
			return (collection as ICollection).getLength();
		}
	}
}