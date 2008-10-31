package com.layerglue.flex3.collections.strategies
{
	import com.layerglue.lib.base.collections.strategies.ArrayCollectionStrategy;
	import com.layerglue.lib.base.collections.strategies.DeserializerCollectionStrategyMap;
	
	import mx.collections.ArrayCollection;

	public class FlexCollectionStrategyMap extends DeserializerCollectionStrategyMap
	{
		public function FlexCollectionStrategyMap()
		{
			super();
			
			addItem(ArrayCollection, new ArrayCollectionStrategy());
		}
		
	}
}