package com.client.project.model.proxies
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import com.layerglue.lib.base.collections.IKeyValuePairCollection;

	public class ConfigProxy extends Proxy
	{
		public static const NAME:String = "ConfigProxy";
		
		public function ConfigProxy(data:IKeyValuePairCollection)
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