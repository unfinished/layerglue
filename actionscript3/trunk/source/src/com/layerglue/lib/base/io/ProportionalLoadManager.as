package com.layerglue.lib.base.io
{
	/**
	 * Wraps MultiLoader to provide a convenient way to add and listen to individual loaders.
	 * This is intended to be subclassed and loaders to be added in the constructor.
	 * Processing of the loaders is begun using the start() method.
	 */
	public class ProportionalLoadManager extends LoadManager
	{
		
		public function ProportionalLoadManager()
		{
			super();
		}
		
	}
}