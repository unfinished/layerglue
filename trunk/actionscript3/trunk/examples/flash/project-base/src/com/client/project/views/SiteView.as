package com.client.project.views
{
	import com.layerglue.flash.views.SpriteExt;
	import flash.net.getClassByAlias;
	import org.puremvc.as3.patterns.facade.Facade;
	import com.client.project.model.proxies.AssetLibraryProxy;
	import flash.display.DisplayObject;
	import com.layerglue.lib.base.utils.PositionUtils;
	import com.client.project.model.proxies.CopyProxy;

	public class SiteView extends SpriteExt
	{
		public function SiteView()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			var assetProxy:AssetLibraryProxy = Facade.getInstance().retrieveProxy(AssetLibraryProxy.NAME) as AssetLibraryProxy;
			var copyProxy:CopyProxy = Facade.getInstance().retrieveProxy(CopyProxy.NAME) as CopyProxy;
			
			var embeddedAsset:DisplayObject = assetProxy.getAsset("embeddedHelloMessage");
			var runtimeAsset:DisplayObject = assetProxy.getAsset("runtimeHelloMessage");
			
			PositionUtils.stackVertical([addChild(embeddedAsset), addChild(runtimeAsset)], 10);
			
			trace("copy:::: "+copyProxy.getValue("project.title"));
		}
		
		override protected function draw():void
		{
			
		}
	}
}