package com.client.project.model.proxies
{
	import com.layerglue.lib.base.collections.IKeyValuePairCollection;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class CopyProxy extends Proxy
	{
		public static const NAME:String = "CopyProxy";
		
		public function CopyProxy(data:IKeyValuePairCollection)
		{
			super(NAME, data);
		}
		
		public function get typedData():IKeyValuePairCollection
		{
			return data as IKeyValuePairCollection;
		}
		
		public function getValue(key:String):String
		{
			return typedData.getValue(key);
		}
	}
}