package com.layerglue.flex3.base.views
{
	import com.layerglue.flex3.base.preloader.DownloadProgressBarExt;
	
	import mx.core.Application;

	public class PreloadableApplication extends Application
	{
		[Inspectable(defaultValue="com.layerglue.flex3.base.preloader.DownloadProgressBarExt")]
		public var loadManager:Object;
		
		[Inspectable(defaultValue="1")]
		public var loadManagerTotalValue:Number = 1;
		
		[Inspectable(defaultValue="0.6")]
		public var loadManagerMainSWFValue:Number;
		
		public function PreloadableApplication()
		{
			super();
		}
		
	}
}