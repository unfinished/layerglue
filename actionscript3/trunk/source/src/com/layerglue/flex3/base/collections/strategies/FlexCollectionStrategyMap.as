package com.layerglue.flex3.base.collections.strategies
{
	import com.layerglue.lib.base.collections.strategies.CollectionStrategyMap;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * A class to extend the standard CollectionStrategyMap adding the ArrayCollectionStrategy as
	 * another collection of which mediated interaction can occur.
	 * 
	 * @see ICollectionStrategy 
	 */
	public class FlexCollectionStrategyMap extends CollectionStrategyMap
	{
		public function FlexCollectionStrategyMap()
		{
			super();
			
			addMapping(ArrayCollection, new ArrayCollectionStrategy());
		}
	}
}