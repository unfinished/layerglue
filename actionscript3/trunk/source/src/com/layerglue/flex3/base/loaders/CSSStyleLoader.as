package com.layerglue.flex3.base.loaders
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.loaders.ILoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import mx.styles.StyleManager;

	public class CSSStyleLoader extends EventDispatcher implements ILoader
	{
		protected var _listenerCollection:EventListenerCollection;
		protected var _request:URLRequest;
		protected var _isComplete:Boolean;
		
		protected var _styleManagerEventDispatcher:IEventDispatcher;
		
		public function CSSStyleLoader(request:URLRequest=null)
		{
			super();
			
			_listenerCollection = new EventListenerCollection();
			_request = request;
			_isComplete = false;
		}
		
		public function isComplete():Boolean
		{
			return _isComplete;
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
		
		private function progressHandler(event:Event):void
		{
			dispatchEvent(new Event(ProgressEvent.PROGRESS));
		}
		
		private function completeHandler(event:Event):void
		{
			_isComplete = true;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function destroy():void
		{
			removeListeners();
		}
	}
}