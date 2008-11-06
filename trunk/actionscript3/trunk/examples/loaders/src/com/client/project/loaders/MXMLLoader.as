package com.client.project.loaders
{
	import com.layerglue.lib.base.loaders.AbstractLoader;
	
	import flash.net.URLRequest;
	
	import mx.core.IMXMLObject;

	public class MXMLLoader extends AbstractLoader implements IMXMLLoader, IMXMLObject
	{
		public var id:String;
		
		public function MXMLLoader(request:URLRequest=null)
		{
			super(request);
		}
		
		public function get url():String
		{
			return _request.url;
		}
		public function set url(value:String):void
		{
			_request = new URLRequest(value);
		}
		
		public function initialized(document:Object, id:String):void
		{
			this.id = id;
		}
	}
}