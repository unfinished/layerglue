package com.layerglue.lib.base.loaders
{
	import com.layerglue.lib.base.core.IDestroyable;
	import com.layerglue.lib.base.events.DestroyEvent;
	import com.layerglue.lib.base.events.EventListenerCollection;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * An abstract base class on which to base loaders providing
	 */
	public class AbstractLoader extends URLLoader implements ISingleLoader, IDestroyable
	{
		protected var _listenerCollection:EventListenerCollection;
		
		public function AbstractLoader(request:URLRequest=null)
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
			return bytesLoaded;
		}
		
		[Bindable(event="open", event="complete", event="progress")]
		public function getBytesTotal():uint
		{
			return bytesTotal;
		}
		
		[Bindable(event="open", event="complete")]
		public function getData():*
		{
			return data;
		}
		
		[Bindable(event="open", event="complete")]
		public function getDataFormat():String
		{
			return dataFormat;
		}
		
		/**
		 * Starts the download of the specified URLRequest.
		 */
		override public function load(request:URLRequest):void
		{
			_request = request;
			_isComplete = false;
			super.load(request);
		}
		
		protected function completeHandler(event:Event):void
		{
			_isComplete = true;
			
			//This method should be overriden in subclasses for dealing with incoming data - casting etc
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
		
		/**
		 * @inheritDoc
		 */
		public function open():void
		{
			if(_request)
			{
				super.load(_request);
			}
			else
			{
				throw new Error("Tried to open a load without a URLRequest being set.");
			}
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
		
		protected function addListeners():void
		{
			_listenerCollection.createListener(this, Event.COMPLETE, completeHandler);
		}
		
		protected function removeListeners():void
		{
			_listenerCollection.removeAll();
		}
	}
}