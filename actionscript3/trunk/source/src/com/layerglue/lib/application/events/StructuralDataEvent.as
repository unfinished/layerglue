package com.layerglue.lib.application.events
{
	import flash.events.Event;

	public class StructuralDataEvent extends Event
	{
		public static const CHILDREN_CHANGE:String = "childrenChange";
		
		public function StructuralDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}