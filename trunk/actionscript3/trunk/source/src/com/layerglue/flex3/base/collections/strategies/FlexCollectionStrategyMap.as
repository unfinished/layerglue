package com.layerglue.flex3.base.collections.strategies
{
	import com.layerglue.lib.base.collections.strategies.DeserializerCollectionStrategyMap;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * A class to extend the standard DeserializerCollectionStrategyMap adding the
	 * ArrayCollectionStrategy as another collection of which mediated interaction can occur.
	 * 
	 * @see ICollectionStrategy 
	 */
	public class FlexCollectionStrategyMap extends DeserializerCollectionStrategyMap
	{
		public function FlexCollectionStrategyMap()
		{
			super();
			
			addItem(ArrayCollection, new ArrayCollectionStrategy());
		}
	}
}