package com.client.project.preloader
{
	import com.layerglue.flash.preloader.IPreloaderConfig;
	
	public class PreloaderConfig implements IPreloaderConfig
	{
		public function PreloaderConfig()
		{
		}
		
		public function get rootLoaderProportion():Number
		{
			return 0.6;
		}
		
		public function get mainClassName():String
		{
			return "Main";
		}

	}
}