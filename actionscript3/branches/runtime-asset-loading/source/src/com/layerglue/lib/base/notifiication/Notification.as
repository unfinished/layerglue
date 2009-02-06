package com.layerglue.lib.base.notifiication
{
	import flash.events.Event;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	
	public class Notification extends Event
	{
		public function Notification(type:String)
		{
			super(type, false, true);
		}
	}
}