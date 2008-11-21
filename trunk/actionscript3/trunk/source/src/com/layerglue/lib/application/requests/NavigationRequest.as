package com.layerglue.lib.application.requests
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.requests.AbstractRequest;
	
	/**
	 * A navigation request specifying a destination and whether or not it should be passed via
	 * SWFAddress and be registered in the browser history
	 */
	public class NavigationRequest extends AbstractRequest
	{
		public function NavigationRequest(destination:IStructuralData, hideFromHistory:Boolean=false)
		{
			super();
			
			this.destination = destination;
			this.hideFromBrowser = hideFromHistory;
		}
		
		private var _destination:IStructuralData;
		
		/**
		 * The node in the structural data hierarchy that should be navigated to 
		 */
		public function get destination():IStructuralData
		{
			return _destination;
		}
		
		public function set destination(value:IStructuralData):void
		{
			_destination = value;
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