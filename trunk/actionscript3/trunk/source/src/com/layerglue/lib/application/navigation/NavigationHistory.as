package com.layerglue.lib.application.navigation
{
	import com.layerglue.lib.application.structure.IStructuralData;
	
	public class NavigationHistory extends Object
	{
		private var _items:Array;
		
		public function NavigationHistory()
		{
			super();
			
			_items = [];
		}
		
		public function addItem(structuralData:IStructuralData):void
		{
			_items.push(structuralData);
		}
		
		public function getPreviousItem():IStructuralData
		{
			return getItemAt(length-2);
		}
		
		public function getItemAt(index:int):IStructuralData
		{
			//TODO Throw error for out of range reqauests.
			return _items[index];
		}
		
		public function get length():int
		{
			return _items.length;
		}
	}
}