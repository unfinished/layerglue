package com.layerglue.flex3.collections
{
	import com.layerglue.lib.base.collections.ICollection;
	import com.layerglue.lib.base.collections.strategies.ArrayCollectionStrategy;
	import com.layerglue.lib.base.collections.strategies.ICollectionStrategy;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * A subclass of ArrayCollection that implements the ICollection interface.
	 */
	[Bindable]
	public class ArrayCollectionExt extends ArrayCollection implements ICollection
	{
		private var _strategy:ICollectionStrategy;
		
		public function ArrayCollectionExt(source:Array = null)
		{
			super(source);
			
			_strategy = new ArrayCollectionStrategy();
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeItem(item:Object):Object
		{
			return _strategy.removeItem(this, item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getLength():int
		{
			return _strategy.getLength(this);
		}
	}
}