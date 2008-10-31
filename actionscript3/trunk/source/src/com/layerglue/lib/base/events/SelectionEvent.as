package com.layerglue.lib.base.events
{
	import flash.events.Event;

	public class SelectionEvent extends Event
	{
		public static const SELECTION_STATUS_CHANGE:String = "selectionStatusChange";
		public static const SUBSELECTION_CHANGE:String = "subselectionChange";
		
		public function SelectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}