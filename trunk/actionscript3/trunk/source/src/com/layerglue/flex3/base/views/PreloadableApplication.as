package com.layerglue.flex3.base.views
{
	import com.layerglue.flex3.base.preloader.DownloadProgressBarExt;
	
	import mx.core.Application;

	public class PreloadableApplication extends Application
	{
		//[Inspectable(defaultValue="com.layerglue.flex3.base.preloader.DownloadProgressBarExt")]
		public var loadManager:Object = "com.layerglue.flex3.base.preloader.DownloadProgressBarExt";
		public var loadManagerTotalValue:Number;
		public var loadManagerMainSWFValue:Number = 0.6;
		
		public function PreloadableApplication()
		{
			super();
		}
		
	}
}