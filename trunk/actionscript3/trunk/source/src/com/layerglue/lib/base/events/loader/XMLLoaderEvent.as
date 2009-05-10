package com.layerglue.lib.base.events.loader
{
	import flash.events.Event;

	public class XMLLoaderEvent extends Event
	{
		public static const INVALID_XML_MARKUP:String = "invalidXMLMarkup";
		
		public function XMLLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}