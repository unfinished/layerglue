package com.layerglue.lib.base.models
{
	import flash.events.EventDispatcher;
	
	public class AbstractModel extends EventDispatcher implements IModel
	{
		public function AbstractModel()
		{
			super();
		}
		
		/* 
		//TODO Work out whether these should actually be in here
		public function dispatchSpecificChangeEvent(event:Event):void
		{
			dispatchEvent(event);
			dispatchGenericChangeEvent();
		}
		
		public function dispatchGenericChangeEvent():void
		{
			trace("Generic event is firing");
			dispatchEvent( new DataProviderEvent(DataProviderEvent.CHANGE, this) );
		}
		*/
		//-------------------------------------------------------
	}
}