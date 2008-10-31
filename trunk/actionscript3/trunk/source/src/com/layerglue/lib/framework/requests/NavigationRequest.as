package com.layerglue.lib.framework.requests
{
	import com.layerglue.lib.base.requests.AbstractRequest;
	import com.layerglue.lib.framework.navigation.INavigable;
	
	/**
	 * A navigation request specifying a destination and whether or not it should be passed via
	 * SWFAddress and be registered in the browser history
	 */
	public class NavigationRequest extends AbstractRequest
	{
		public function NavigationRequest(destination:INavigable, hideFromHistory:Boolean=false)
		{
			super();
			
			this.destination = destination;
			this.hideFromHistory = hideFromHistory;
		}
		
		private var _destination:INavigable;
		
		/**
		 * The node in the structural data hierarchy that should be navigated to 
		 */
		public function get destination():INavigable
		{
			return _destination;
		}
		
		public function set destination(value:INavigable):void
		{
			_destination = value;
		}
		
		private var _hideFromHistory:Boolean;
		
		/**
		 * Whether or not the request should go through SWFAddress and be registered in the
		 * browser's history.
		 */
		public function get hideFromHistory():Boolean
		{
			return _hideFromHistory;
		}

		public function set hideFromHistory(value:Boolean):void
		{
			_hideFromHistory = value;
		}
	}
}