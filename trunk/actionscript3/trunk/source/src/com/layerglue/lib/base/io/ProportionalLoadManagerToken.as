package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.loaders.IMeasurableLoader;

	public class ProportionalLoadManagerToken extends LoadManagerToken
	{
		public function ProportionalLoadManagerToken(loader:IMeasurableLoader, completeHandler:Function, errorHandler:Function, proportion:Number=NaN)
		{
			super(loader, completeHandler, errorHandler);
			
			this.proportion = proportion;
		}
		
		private var _proportion:Number;
		
		public function get proportion():Number
		{
			return _proportion;
		}
		
		public function set proportion(value:Number):void
		{
			_proportion = value;
		}
		
	}
}