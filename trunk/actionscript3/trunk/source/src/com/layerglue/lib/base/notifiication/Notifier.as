package com.layerglue.lib.base.notifiication
{
	import flash.events.EventDispatcher;

	public class Notifier extends EventDispatcher
	{
		public function Notifier()
		{
			super();
		}
		
		public function subscribe(type:String, handler:Function):void
		{
			addEventListener(type, handler, false, 0, true);
		}
		
		public function unsubscribe(type:String, handler:Function):void
		{
			removeEventListener(type, handler, false);
		}

	}
}