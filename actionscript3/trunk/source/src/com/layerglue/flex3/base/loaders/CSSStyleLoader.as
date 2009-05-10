package com.layerglue.flex3.base.loaders
{
	import com.layerglue.lib.base.events.EventListenerCollection;
	import com.layerglue.lib.base.loaders.IMeasurableLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import mx.styles.StyleManager;

	public class CSSStyleLoader extends EventDispatcher implements IMeasurableLoader
	{
		protected var _listenerCollection:EventListenerCollection;
		protected var _styleManagerEventDispatcher:IEventDispatcher;
		
		public function CSSStyleLoader(request:URLRequest=null)
		{
			super();
			
			_listenerCollection = new EventListenerCollection();
			_request = request;
			_isComplete = false;
		}
		
		protected var _request:URLRequest;
		
		public function get request():URLRequest
		{
			return _request;
		}
		
		protected var _isComplete:Boolean;
		
		public function isComplete():Boolean
		{
			return _isComplete;
		}
		
		private var _bytesLoaded:Number;
		
		public function getBytesLoaded():uint
		{
			return _bytesLoaded;
		}
		
		private var _bytesTotal:Number;
		
		public function getBytesTotal():uint
		{
			return _bytesTotal;
		}
		
		public function open():void
		{
			removeListeners();
			
			_isComplete = false;
			
			dispatchEvent(new Event(Event.OPEN));
			_styleManagerEventDispatcher = StyleManager.loadStyleDeclarations(_request.url);
			
			addListeners();
		}
		
		public function close():void
		{
			//Cant stop the StyleManager, so cant do anything here unfortuntately
		}
		
		private function addListeners():void
		{
			_listenerCollection.createListener(_styleManagerEventDispatcher, Event.COMPLETE, completeHandler);
			_listenerCollection.createListener(_styleManagerEventDispatcher, ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function removeListeners():void
		{
			_listenerCollection.removeAll();
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			_bytesLoaded = event.bytesLoaded;
			_bytesTotal = event.bytesTotal;
			
			dispatchEvent(event.clone());
		}
		
		private function completeHandler(event:Event):void
		{
			_isComplete = true;
			
			dispatchEvent(event.clone());
		}
		
		public function destroy():void
		{
			removeListeners();
		}
	}
}