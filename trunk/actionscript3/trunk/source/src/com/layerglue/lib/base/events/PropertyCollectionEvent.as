package com.layerglue.lib.base.events
{
	import flash.events.Event;

	public class PropertyCollectionEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "PropertyCollectionEvent_loadComplete";
		public static const DESERIALIZE_COMPLETE:String = "PropertyCollectionEvent_deserializeComplete";
		
		public function PropertyCollectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}