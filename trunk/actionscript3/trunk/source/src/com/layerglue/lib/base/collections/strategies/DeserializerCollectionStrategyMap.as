package com.layerglue.lib.base.collections.strategies
{
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.utils.ReflectionUtils;

	public class DeserializerCollectionStrategyMap extends Object
	{
		private var _map:HashMap;
		
		public function DeserializerCollectionStrategyMap()
		{
			super();
			
			_map = new HashMap();
			
			addItem(Array, new ArrayStrategy());
		}
		
		public function addItem(type:Class, strategy:ICollectionStrategy):void
		{
			_map.put(type, strategy);
		}
		
		public function getStrategyByInstance(obj:Object):ICollectionStrategy
		{
			var strategy:ICollectionStrategy = getStrategtyByType(ReflectionUtils.getClassReference(obj));
			
			//If there is a specific type returned the mapped class
			if(strategy)
			{
				return strategy;
			}
			//If the object being passed in is an Array and no specific strategy is specified return
			//an Array Strategy
			else if(obj is Array)
			{
				return getStrategtyByType(Array);
			}
			
			return null;
		}
		
		public function getStrategtyByType(type:Class):ICollectionStrategy
		{
			return _map.get(type) as ICollectionStrategy;
		}
	}
}