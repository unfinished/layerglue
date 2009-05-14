package com.layerglue.lib.base.collections.strategies
{
	import com.layerglue.lib.base.collections.ArrayExt;
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.utils.ReflectionUtils;

	/**
	 * 
	 */
	public class CollectionStrategyMap extends Object
	{
		private var _map:HashMap;
		
		public function CollectionStrategyMap()
		{
			super();
			
			_map = new HashMap();
			
			addMapping(Array, new ArrayStrategy());
			addMapping(ArrayExt, new CollectionStrategy());
		}
		
		/**
		 * Adds a mapping beteween a collection type and a Strategy.
		 */
		public function addMapping(type:Class, strategy:ICollectionStrategy):void
		{
			_map.putValue(type, strategy);
		}
		
		/**
		 * Removes a mapping
		 * 
		 * @returns Whether or not the item was present and could be removed
		 */
		public function removeMapping(type:Class):Boolean
		{
			return _map.removeValue(type);
		}
		
		/**
		 * Returns the strategy to deal with the specified instance, or null if one cannot be found.
		 * <p>As well as returning simple mappings, if the object is an Array (or Array Subclass) a
		 * ArrayStrategy will be returned.</p>
		 * 
		 * @param collection The collection instance to match on.
		 * 
		 * @returns The corresponding ICollectionStrategy instance or null if one cannot be found
		 */
		public function getStrategyByInstance(collection:Object):ICollectionStrategy
		{
			var strategy:ICollectionStrategy = getStrategtyByType(ReflectionUtils.getClassReference(collection));
			
			//If there is a specific type returned the mapped class
			if(strategy)
			{
				return strategy;
			}
			//If the object being passed in is an Array and no specific strategy is specified return
			//an Array Strategy
			else if(collection is Array)
			{
				return getStrategtyByType(Array);
			}
			
			return null;
		}
		
		/**
		 * Return a strategy mapped to the specified type or null if one cannot be found.
		 * 
		 * @param type The type to match on.
		 */
		public function getStrategtyByType(type:Class):ICollectionStrategy
		{
			return _map.getValue(type) as ICollectionStrategy;
		}
	}
}