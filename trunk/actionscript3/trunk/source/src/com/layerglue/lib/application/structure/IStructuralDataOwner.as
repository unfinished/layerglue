package com.layerglue.lib.application.structure
{
	import com.layerglue.lib.application.structure.IStructuralData;
	
	[Bindable]
	public interface IStructuralDataOwner
	{
		/**
		 * The structural data for this view.
		 */
		function get structuralData():IStructuralData
		function set structuralData(value:IStructuralData):void
	}
}