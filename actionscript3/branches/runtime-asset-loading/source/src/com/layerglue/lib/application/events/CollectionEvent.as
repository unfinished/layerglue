package com.layerglue.lib.application.events
{
	import flash.events.Event;

	public class CollectionEvent extends Event
	{
		
		public static const COLLECTION_CHANGE:String = "lg_collectionChange";
		
		public function CollectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var kind:String;
		public var items:Array;
		public var location:int;
		public var oldLocation:int;
		
	}
}