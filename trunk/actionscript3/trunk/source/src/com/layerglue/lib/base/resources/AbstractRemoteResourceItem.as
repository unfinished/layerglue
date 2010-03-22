package com.layerglue.lib.base.resources 
{
	import com.layerglue.lib.base.io.LoadManagerToken;
	import com.layerglue.lib.base.loaders.ILoader;

	/**
	 * @author Jamie Copeland
	 */
	public class AbstractRemoteResourceItem extends LoadManagerToken implements IRemoteResourceItem
	{
		public function AbstractRemoteResourceItem(loader : ILoader = null, completeHandler : Function = null, errorHandler : Function = null, proportion : Number = NaN)
		{
			super(loader, completeHandler, errorHandler, proportion);
		}

		protected var _id : String;

		public function get id() : String
		{
			return _id;
		}

		public function set id(value : String) : void
		{
			_id = value;
		}

		protected var _url : String;

		public function get url() : String
		{
			return _url;
		}

		public function set url(value : String) : void
		{
			_url = value;
		}
	}
}
