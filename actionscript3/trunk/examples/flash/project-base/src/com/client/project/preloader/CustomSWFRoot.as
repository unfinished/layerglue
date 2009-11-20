package com.client.project.preloader
{
	import com.client.project.constants.LoadProportionConstants;
	import com.layerglue.flash.preloader.AbstractSWFRoot;
	import com.layerglue.flash.preloader.FlashPreloadManager;
	
	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class CustomSWFRoot extends AbstractSWFRoot
	{
		public function CustomSWFRoot()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_preloaderView = new PreloaderView(FlashPreloadManager.getInstance());
			addChild(_preloaderView as DisplayObject);
		}
		
		override public function get rootLoadProportion():Number
		{
			return LoadProportionConstants.ROOT;
		}
		
	}
}