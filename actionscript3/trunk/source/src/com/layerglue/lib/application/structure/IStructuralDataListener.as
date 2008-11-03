package com.layerglue.lib.application.structure
{
	import com.layerglue.lib.base.core.IDestroyable;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.application.structure.IStructuralData;
	
	[Bindable]
	public interface IStructuralDataListener extends IStructuralDataOwner, IDestroyable
	{
		/**
		 * <p>A method that is triggered when the dataProvider property is changed completely i.e.
		 * from null to an Object instance, or from one instance to another instance and NOT when
		 * one or more of the internal properties of the data provider changes.</p>
		 * 
		 * <p>This method exists to provide a place for removing event listeners from the old data
		 * provider and ones to the new one.</p>
		 * 
		 * <p>Any internal changes that need to be listened to should done either via binding,
		 * manual listeners (created in this method), or using the DataProviderListenerProxy and passing in an
		 * eventMethodMap.</p>
		 */
		function structuralDataPropertyChangeHandler(oldStructuralData:IStructuralData, newStructuralData:IStructuralData):void
		
		function structuralDataSubselectionChangeHandler(event:SelectionEvent):void
		function structuralDataSelectionStatusChangeHandler(event:SelectionEvent):void
	}
}