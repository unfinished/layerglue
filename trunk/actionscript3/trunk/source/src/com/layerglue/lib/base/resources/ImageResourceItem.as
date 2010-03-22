package com.layerglue.lib.base.resources 
{
	import com.layerglue.flash.loaders.DisplayLoader;
	import com.layerglue.lib.base.loaders.ILoader;

	import flash.net.URLRequest;

	/**
	 * @author Jamie Copeland
	 */
	public class ImageResourceItem extends AbstractRemoteResourceItem implements IRemoteResourceItem
	{
		public function ImageResourceItem(loader : ILoader = null, completeHandler : Function = null, errorHandler : Function = null, proportion : Number = NaN)
		{
			super(loader, completeHandler, errorHandler, proportion);
		}

		override public function get loader() : ILoader
		{
			if(!_loader && url)
			{
				_loader = new DisplayLoader(new URLRequest(url));
			}
			return _loader;
		}
	}
}
