package com.client.project.model.proxies
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import com.layerglue.lib.base.assets.AssetLibrary;
	import flash.display.DisplayObject;

	public class AssetLibraryProxy extends Proxy
	{
		public static const NAME:String = "AssetLibraryProxy";
		
		public function AssetLibraryProxy(data:AssetLibrary)
		{
			super(NAME, data);
		}
		
		public function get typedData():AssetLibrary
		{
			return data as AssetLibrary
		}
		
		public function getAssetClass(className:String):Class
		{
			return typedData.getAssetClass(className);
		}
		
		public function getAsset(className:String):DisplayObject
		{
			return typedData.getAsset(className);
		}
		
	}
}