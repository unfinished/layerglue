package com.layerglue.lib.base.events
{
	import flash.events.Event;

	public class AssetLibraryEvent extends Event
	{
		public static var EMBED_COMPLETE:String = "embedComplete";
		
		public function AssetLibraryEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new AssetLibraryEvent(type, bubbles, cancelable);
		}
	}
}