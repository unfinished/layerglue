package com.layerglue.lib.application.proxies
{
	import com.layerglue.lib.base.collections.EventListenerCollection;
	import com.layerglue.lib.base.core.IDestroyable;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.structure.IStructuralDataListener;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class StructuralDataListenerUtil extends EventDispatcher implements
		IDestroyable,
		IEventDispatcher
	{
		private var _host:IStructuralDataListener;
		private var _listenerCollection:EventListenerCollection;
		
		public function StructuralDataListenerUtil(host:IStructuralDataListener):void
		{
			_host = host;
			_listenerCollection = new EventListenerCollection();
		}
		
		private var _structuralData:IStructuralData;

		public function get structuralData():IStructuralData
		{
			return _structuralData;
		}

		public function set structuralData(value:IStructuralData):void
		{
			if(_structuralData != value)
			{
				var oldDp:IStructuralData = _structuralData;
				_structuralData = value;
				structuralDataPropertyChangeHandler(oldDp, _structuralData);
			}
		}
		
		public function structuralDataPropertyChangeHandler(oldStructuralData:IStructuralData, newStructuralData:IStructuralData):void
		{
			removeEventListeners();
			addEventListeners();
			_host.structuralDataPropertyChangeHandler(oldStructuralData, newStructuralData);
		}
		
		private function addEventListeners():void
		{
			//trace("===== DataProviderListenerProxy.addEventListeners =====");
			//trace("_host: " + _host);
			//trace("======================================");
			
			removeEventListeners();
			
			_listenerCollection.createListener(structuralData, SelectionEvent.SELECTION_STATUS_CHANGE, _host.structuralDataSelectionStatusChangeHandler);
			_listenerCollection.createListener(structuralData, SelectionEvent.SUBSELECTION_CHANGE, _host.structuralDataSubselectionChangeHandler);
		}
		
		public function removeEventListeners():void
		{
			
			//trace("===== DataProviderListenerProxy.removeEventListeners =====");
			//trace("host: " + _host);
			//trace("=========================================");
			
			if(_listenerCollection)
			{
				_listenerCollection.removeAll();
			}
		}
		
		public function destroy():void
		{
			removeEventListeners();
		}
	}
}