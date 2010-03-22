package com.layerglue.lib.base.resources 
{
	import com.layerglue.lib.base.loaders.XmlLoader;
	import com.layerglue.lib.base.loaders.ILoader;


	import flash.net.URLRequest;

	/**
	 * @author Jamie Copeland
	 */
	public class XMLResourceItem extends AbstractRemoteResourceItem 
	{
		public function XMLResourceItem(loader : ILoader = null, completeHandler : Function = null, errorHandler : Function = null, proportion : Number = NaN)
		{
			super(loader, completeHandler, errorHandler, proportion);
		}
		
		override public function get loader() : ILoader
		{
			if(!_loader && url)
			{
				_loader = new XmlLoader(new URLRequest(url));
			}
			return _loader;
		}
	}
}
