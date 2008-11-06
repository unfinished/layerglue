package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.loaders.IMeasurableLoader;

	public class ProportionalLoadManagerToken extends LoadManagerToken
	{
		public function ProportionalLoadManagerToken(loader:IMeasurableLoader, completeHandler:Function, errorHandler:Function, proportion:Number=NaN)
		{
			super(loader, completeHandler, errorHandler, proportion);
		}
		
	}
}