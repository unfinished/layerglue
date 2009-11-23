package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.loaders.IMeasurableLoader;
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;

	/**
	 * 
	 */
	public class ProportionalLoadManager extends LoadManager
	{
		
		public function ProportionalLoadManager()
		{
			super();
		}
		
		private var _totalValue:Number;
		
		public function get totalValue():Number
		{
			return _totalValue;
		}
		
		public function set totalValue(value:Number):void
		{
			_totalValue = value;
		}
		
		public function get currentValue():Number
		{
			return calculateCurrentValue();
		}
		
		override protected function itemProgressHandler(event:MultiLoaderEvent):void
		{
			super.itemProgressHandler(event);
			
			//trace(">>>>>  "+currentValue +"/"+totalValue)
		}
		
		//TODO Look into Infinity value and O being passed back as totalBytes of URLLoaderExt
		private function calculateCurrentValue():Number
		{
			var proportionLoaded:Number = 0;;
			
			for each(var item:LoadManagerToken in _loadManagerItems)
			{
				if(item.loader.isComplete())
				{
					proportionLoaded += item.proportion;
					//trace(" adding fully loaded: " + item.proportion);
				}
				else //If we get here there is still an item loading
				{
					//Get the loader contained within the item
					var measurableLoader:IMeasurableLoader = item.loader as IMeasurableLoader;
					
					//Calculate the fraction of the currently loading item's proportion
					var measurableLoaderProportion:Number = item.proportion * (measurableLoader.getBytesLoaded() / measurableLoader.getBytesTotal());
					
					//trace(" adding semi loaded: " + measurableLoaderProportion + " (" +measurableLoader.getBytesLoaded() + " / " + measurableLoader.getBytesTotal()+ ") " + measurableLoader );
					
					//Add the fractional proportion to the overall value
					proportionLoaded += (isNaN(measurableLoaderProportion) || measurableLoaderProportion==Infinity ) ? 0 : measurableLoaderProportion;
					
					//Make sure to stop here, as this item is loading, and all after this are
					//waiting to load
					break;
				}
			}
			//trace(" proportionLoaded: " + proportionLoaded);
			return proportionLoaded;
		}
		
		public function fraction():Number
		{
			return currentValue / totalValue;
		}
	}
}