package com.layerglue.lib.base.collections
{
	import com.layerglue.lib.base.core.ISelectable;
	import com.layerglue.lib.base.events.SelectionEvent;
	import com.layerglue.lib.base.models.vos.BusinessValueObject;
	import com.layerglue.lib.base.models.vos.IBusinessValueObject;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	[Event(name="subselectionChange", type="com.layerglue.lib.base.events.SelectionEvent")]
	[Event(name="selectionStatusChange", type="com.layerglue.lib.base.events.SelectionEvent")]
	
	//TODO Make an interface for ISelectableBusinessValueObjectCollection 
	dynamic public class SelectableBusinessValueObjectCollection extends BusinessValueObjectCollection
	{
		public function SelectableBusinessValueObjectCollection()
		{
			super();
			
			_selectedIndex = -1;
		}
		
		protected var _selectedIndex:int
		
		[Bindable(event="subselectionChange")]
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(index:int):void
		{
			if(index > length-1)
			{
				throw new Error("Tried to set selectedIndex to out of range value - length: " + length + ", index: " + index );
			}
			
			_selectedIndex = (isNaN(index)) ? -1 : index;
			
			refreshSubselections();
			
			dispatchEvent(new SelectionEvent(SelectionEvent.SUBSELECTION_CHANGE));
		}
		
		[Bindable(event="subselectionChange")]
		public function get selectedItem():IBusinessValueObject
		{
			return getItemAtIndex(selectedIndex) as IBusinessValueObject;
		}
		
		public function set selectedItem(value:IBusinessValueObject):void
		{
			if(!ArrayUtils.contains(this, value))
			{
				throw new Error("Tried to set selectedItem to a value not contained by this collection: " + value + ", id: " + value.id);
			}
			
			selectedIndex = getItemIndexById(value.id);
		}
		
		private function refreshSubselections():void
		{
			var item:BusinessValueObject;
			//trace("----- refreshSubselections " + length + " -----");
			for(var i:int=0 ; i<length ; i++)
			{
				item = getItemAtIndex(i);
				
				if(item is ISelectable)
				{
					(item as ISelectable).selected = i == selectedIndex;
					//trace("item: " + i + " - " + item + ".selected: " + (item as ISelectable).selected);
				}
			}
			//trace("-------------------------------");
		}
		
		public function deselect():void
		{
			selectedIndex = -1;
		}
		
		override public function toString():String
		{
			return "[ " + ReflectionUtils.getClassName(this) + " ]";
		}
	}
}