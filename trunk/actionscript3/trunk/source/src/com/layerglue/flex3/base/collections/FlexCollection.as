package com.layerglue.flex3.base.collections
{
	import com.layerglue.flex3.base.collections.strategies.ArrayCollectionStrategy;
	import com.layerglue.lib.base.collections.ICollection;
	import com.layerglue.lib.base.collections.strategies.ICollectionStrategy;
	
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
	}
}