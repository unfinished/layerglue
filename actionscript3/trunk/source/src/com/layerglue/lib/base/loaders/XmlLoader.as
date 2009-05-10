package com.layerglue.lib.base.loaders
{
	import com.layerglue.lib.base.events.loader.XMLLoaderEvent;

	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * Specifically designed for loading XML, on load complete this class creates an XML instance
	 * and stores it in its typedData property.
	 * 
	 * <p><b>Note</b>The typed data is a convention used in concrete
	 * implementations of Abstract loader to provide a regular way to access a loaders data once
	 * complete.<p>
	 */
	public class XmlLoader extends AbstractLoader
	{
		public function XmlLoader(request:URLRequest=null)
		{
			super(request);
		}
		
		override protected function completeHandler(event:Event):void
		{
			super.completeHandler(event);
			
			try
			{
				data = new XML(this.data);
			}
			catch(error:Error)
			{
				dispatchEvent(new XMLLoaderEvent(XMLLoaderEvent.INVALID_XML_MARKUP));
			}
		}
		
		public function get typedData():XML
		{
			return new XML(data);
		}
		
	}
}