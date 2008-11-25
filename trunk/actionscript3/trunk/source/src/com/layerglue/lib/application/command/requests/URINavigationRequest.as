package com.layerglue.lib.application.command.requests
{
	import com.layerglue.lib.base.requests.AbstractRequest;

	public class URINavigationRequest extends AbstractRequest
	{
		public function URINavigationRequest(uri:String, hideFromBrowser:Boolean=false)
		{
			super();
			
			this.uri = uri;
			this.hideFromBrowser = hideFromBrowser;
		}
		
		private var _uri:String;
		
		/**
		 * The URI
		 */
		public function get uri():String
		{
			return _uri;
		}
		
		public function set uri(value:String):void
		{
			_uri = value;
		}
		
		private var _hideFromBrowser:Boolean;
		
		/**
		 * Whether or not the request should go through SWFAddress and be registered in the
		 * browser's history.
		 */
		public function get hideFromBrowser():Boolean
		{
			return _hideFromBrowser;
		}

		public function set hideFromBrowser(value:Boolean):void
		{
			_hideFromBrowser = value;
		}
		
	}
}