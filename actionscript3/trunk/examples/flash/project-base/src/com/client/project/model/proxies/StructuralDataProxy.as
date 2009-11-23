package com.client.project.model.proxies
{
	import com.client.project.structure.Site;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class StructuralDataProxy extends Proxy
	{
		public static const NAME:String = "StructuralDataProxy";
		
		public function StructuralDataProxy(data:Site)
		{
			super(NAME, data);
		}
		
		public function get typedData():Site
		{
			return data as Site;
		}
	}
}