package com.layerglue.lib.application.requests
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.requests.AbstractRequest;
	
	/**
	 * A navigation request specifying a destination and whether or not it should be passed via
	 * SWFAddress and be registered in the browser history
	 */
	public class StructuralDataNavigationRequest extends AbstractRequest
	{
		public function StructuralDataNavigationRequest(destination:IStructuralData, hideFromBrowser:Boolean=false)
		{
			super();
			
			this.structuralData = destination;
			this.hideFromBrowser = hideFromBrowser;
		}
		
		private var _structuralData:IStructuralData;
		
		/**
		 * The node in the structural data hierarchy that should be navigated to 
		 */
		public function get structuralData():IStructuralData
		{
			return _structuralData;
		}
		
		public function set structuralData(value:IStructuralData):void
		{
			_structuralData = value;
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