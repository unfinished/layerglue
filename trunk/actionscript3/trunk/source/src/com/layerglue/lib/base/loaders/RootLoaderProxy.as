package com.layerglue.lib.base.loaders
{
	import com.layerglue.lib.base.events.EventListenerCollection;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	/**
	 * A class to represent the main swf when performing load procedures in the LayerGlue loader
	 * subframework.
	 * 
	 * <p>The class aheres to IMeasurable loader, as well as dispatching progress and complete
	 * events and can be used within a standard MultiLoader or the more complex load managers.<p> 
	 */
	public class RootLoaderProxy extends EventDispatcher implements IMeasurableLoader
	{
		private var _rootLoaderInfo:LoaderInfo;
		
		public function RootLoaderProxy(rootLoaderInfo:LoaderInfo)
		{
			super();
			
			_rootLoaderInfo = rootLoaderInfo;
			
			_isComplete = _rootLoaderInfo.bytesLoaded > 0 &&  _rootLoaderInfo.bytesLoaded == _rootLoaderInfo.bytesTotal;
			
			_rootLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
			_rootLoaderInfo.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		private function completeHandler(event:Event):void
		{
			_isComplete = true;
			dispatchEvent(event.clone());
		}
		
		/**
		 * An unused method, as the main swf will always begin its load.
		 */
		public function open():void
		{
		}
		
		/**
		 * An unused method, as the main swf cannot have its load closed.
		 */
		public function close():void
		{
		}
		
		private var _isComplete:Boolean;
		
		public function isComplete():Boolean
		{
			return _isComplete;
		}
		
		public function getBytesLoaded():uint
		{
			return _rootLoaderInfo.bytesLoaded;
		}
		
		public function getBytesTotal():uint
		{
			return _rootLoaderInfo.bytesTotal;
		}
		
	}
}