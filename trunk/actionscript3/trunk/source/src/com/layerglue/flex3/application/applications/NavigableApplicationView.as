package com.layerglue.flex3.application.applications
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.layerglue.lib.application.requests.RawNavigationRequest;
	
	import flash.events.Event;
	
	public class NavigableApplicationView extends ApplicationView
	{
		public function NavigableApplicationView()
		{
			super();
			
			initializeSWFAddress();
			
			_isFirstNavigation = true;
		}
		
		override protected function startup():void
		{
			super.startup();
		}
		
		private function initializeSWFAddress():void
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, swfAddressChangeHandler);
		}
		
		private var _isFirstNavigation:Boolean;
		private var _firstUri:String;
		
		public function getFirstURI():String
		{
			return _firstUri;
		}
		
		private function swfAddressChangeHandler(event:Event):void
		{
			if(_isFirstNavigation)
			{
				_firstUri = SWFAddress.getValue();
				_isFirstNavigation = false;
			}
			else
			{
				(new RawNavigationRequest(SWFAddress.getValue())).dispatch();
			}
		}
		
		
	}
}