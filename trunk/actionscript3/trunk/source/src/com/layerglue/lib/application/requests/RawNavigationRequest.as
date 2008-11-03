package com.layerglue.lib.application.requests
{
	import com.layerglue.lib.base.requests.AbstractRequest;
	
	public class RawNavigationRequest extends AbstractRequest
	{
		public function RawNavigationRequest(uri:String)
		{
			super();
			
			this.uri = uri;
		}
		
		private var _uri:String;

		public function get uri():String
		{
			return _uri;
		}

		public function set uri(v:String):void
		{
			_uri = v;
		}
		
	}
}