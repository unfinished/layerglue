package com.layerglue.lib.application.events
{
	import flash.events.Event;

	public class StructuralDataListenerEvent extends Event
	{
		public static const STRUCTURAL_DATA_CHANGE:String = "structuralDataChange";
		
		public function StructuralDataListenerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

	}
}