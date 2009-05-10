package com.layerglue.flash.loaders
{
	import com.layerglue.lib.base.events.DestroyEvent;
	import com.layerglue.lib.base.events.EventListenerCollection;
	import com.layerglue.lib.base.loaders.IMeasurableLoader;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	public class DisplayLoader extends Loader implements IMeasurableLoader
	{
		protected var _listenerCollection:EventListenerCollection;
		
		public function DisplayLoader(request:URLRequest=null)
		{
			super();
			
			_listenerCollection = new EventListenerCollection();
			_request = request;
			_isComplete = false;
			
			addListeners();
		}
		
		protected var _request:URLRequest;
		
		public function get request():URLRequest
		{
			return _request;
		}
		
		protected var _isComplete:Boolean;
		
		/**
		 * @inheritDoc
		 */
		[Bindable(event="complete")]
		public function isComplete():Boolean
		{
			return _isComplete;
		}
		
		[Bindable(event="open", event="complete", event="progress")]
		public function getBytesLoaded():uint
		{
			return contentLoaderInfo.bytesLoaded;
		}
		
		[Bindable(event="open", event="complete", event="progress")]
		public function getBytesTotal():uint
		{
			return contentLoaderInfo.bytesTotal;
		}
		
		override public function load(request:URLRequest, context:LoaderContext=null):void
		{
			_isComplete = false;
			super.load(request, context);
		}
		
		/**
		 * @inheritDoc
		 */
		public function open():void
		{
			if(_request)
			{
				super.load(request);
			}
			else
			{
				throw new Error("Tried to open a load without a URLRequest being set.");
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function close():void
		{
			super.close();
			
			//TODO Look into only firing this if the loader is actually loading
			dispatchEvent(new Event(Event.CLOSE));
		}
		
		private function addListeners():void
		{
			_listenerCollection.createListener(contentLoaderInfo, ProgressEvent.PROGRESS, progressHandler);
			_listenerCollection.createListener(contentLoaderInfo, Event.COMPLETE, completeHandler);
		}
		
		private function removeListeners():void
		{
			_listenerCollection.removeAll();
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		private function completeHandler(event:Event):void
		{
			_isComplete = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Stops the download, removes any internal listeners and dispatches a DestroyEvent.
		 */
		public function destroy():void
		{
			close();
			removeListeners();
			dispatchEvent(new DestroyEvent(DestroyEvent.DESTROY));
		}
	}
}