package com.layerglue.lib.base.io
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.loaders.ILoader;
	
	import flash.events.Event;
	
	/**
	* Helper class used to encapsulate the loader and it's associated handlers.
	* It creates a link between the loader complete event and the handler passed into
	* the addItem() method. This means the method specified in addItem() gets called the
	* moment the loader completes.
	*/
	public class LoadManagerItem
	{
		public var loader:ILoader;
		public var proportion:Number;
		
		private var _listenerCollection:EventListenerCollection;
		
		public function LoadManagerItem(loader:ILoader, completeHandler:Function, errorHandler:Function, proportion:Number=NaN)
		{
			this.loader = loader;
			this.proportion = proportion;
			
			_listenerCollection =  new EventListenerCollection();
			_listenerCollection.createListener(loader, Event.COMPLETE, completeHandler);
		}
		
		public function destroy():void
		{
			_listenerCollection.removeAll();
			
			loader = null;
			_listenerCollection = null;
		}
	}
}