package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.loaders.ILoader;
	
	import flash.events.Event;
	
	/**
	* A wrapper class used to encapsulate the loader and it's associated handlers.
	* It creates a link between the loader complete event and the handler passed into
	* the addItem() method. This means the method specified in addItem() gets called the
	* moment the loader completes.
	*/
	public class LoadManagerToken
	{
		protected var _listenerCollection:EventListenerCollection;
		
		public function LoadManagerToken(loader:ILoader, completeHandler:Function=null, errorHandler:Function=null)
		{
			this.loader = loader;
			
			_listenerCollection =  new EventListenerCollection();
			
			if(completeHandler != null)
			{
				_listenerCollection.createListener(loader, Event.COMPLETE, completeHandler);
			}
			
			if(errorHandler != null)
			{
				//TODO listen for errors here
			}
		}
		
		public function destroy():void
		{
			loader.close();
			loader = null;
			
			_listenerCollection.removeAll();
			_listenerCollection = null;
		}
		
		private var _loader:ILoader;
		
		public function get loader():ILoader
		{
			return _loader;
		}
		
		public function set loader(value:ILoader):void
		{
			_loader = value;
		}
	}
}