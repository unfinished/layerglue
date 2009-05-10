package com.layerglue.lib.base.notifiication
{
	import flash.events.Event;

	public class Notification extends Event
	{
		public function Notification(type:String)
		{
			super(type, false, true);
		}
	}
}