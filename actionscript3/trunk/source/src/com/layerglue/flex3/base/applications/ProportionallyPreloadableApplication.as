package com.layerglue.flex3.base.applications
{
	import mx.core.Application;

	public class ProportionallyPreloadableApplication extends Application implements IProportionallyPreloadableApplication
	{
		public function ProportionallyPreloadableApplication()
		{
			super();
		}
		
		private var _loadManager:Class;
		
		/**
		 * @inheritDoc
		 */
		[Inspectable(defaultValue="com.layerglue.flex3.base.preloader.DownloadProgressBarExt")]
		public function get loadManager():Class
		{
			return _loadManager;
		}
		
		public function set loadManager(value:Class):void
		{
			_loadManager = value;
		}
		
		private var _loadManagerTotalValue:Number
		
		/**
		 * @inheritDoc
		 */
		[Inspectable(defaultValue="1")]
		public function get loadManagerTotalValue():Number
		{
			return _loadManagerTotalValue;
		}
		
		public function set loadManagerTotalValue(value:Number):void
		{
			_loadManagerTotalValue = value;
		}
		
		private var _loadManagerMainSWFValue:Number;
		
		/**
		 * @inheritDoc
		 */
		[Inspectable(defaultValue="0.6")]
		public function get loadManagerMainSWFValue():Number
		{
			return _loadManagerMainSWFValue;
		}
		
		public function set loadManagerMainSWFValue(value:Number):void
		{
			_loadManagerMainSWFValue = value;
		}
		
	}
}