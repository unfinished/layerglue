package com.layerglue.flex3.base.controls
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.controls.TabBar;
	import mx.core.mx_internal;
	import mx.events.ItemClickEvent;
	
	use namespace mx_internal;
	
	[Style(name="selectorDistance", type="Number", inherit="no")]
	
	/**
	 * Changes the way the toggle bar deals with data providers and selected index
	 * so it's compatible with the navigation framework.
	 * 
	 * The dataProvider doesn't change if the same object is passed in again.
	 * This prevents the menu from flickering everytime the navigation framework passes
	 * in exactly the same dataProvider.
	 * 
	 * The selectedIndex is no longer changed by clicking the buttons. It HAS to be
	 * changed using the selectedIndex property. This ensures the navigation framework
	 * is the only one that changes the selected menu item.
	 */
	public class NavSafeToggleButtonBar extends TabBar
	{
		public function NavSafeToggleButtonBar()
		{
			super();
		}
		
		override protected function hiliteSelectedNavItem(index:int):void
    	{
    		// FIX: When binding passes through selectedIndex of null it gets converted
    		// into a 0, which is stored and then applied after the dataProvider is set.
    		// If dataProvider is null this causes a run-time crash, because there isn't
    		// a button to hilite at position 0. We prevent that here by double-checking
    		// dataProvider is truly null.
    		if (dataProvider != null)
    		{
    			super.hiliteSelectedNavItem(index);
    		}
    	}
    	
    	// Totally override the click handler so that the ButtonBar doesn't go and 
    	// set the selectedIndex by itself. Instead we want the selectedIndex to be
    	// set by the binding to the structuralData.
    	override protected function clickHandler(event:MouseEvent):void
    	{
    		//trace(event.type);
    		// We JUST dispatch the ItemClick event here, and don't do super.clickHandler
    		// which is usually responsible for immediately setting the selected index
	    	var index:int = getChildIndex(DisplayObject(event.currentTarget));
	
	        var newEvent:ItemClickEvent =
	            new ItemClickEvent(ItemClickEvent.ITEM_CLICK);
	        newEvent.label = Button(event.currentTarget).label;
	        newEvent.index = index;
	        newEvent.relatedObject = InteractiveObject(event.currentTarget);
	        newEvent.item = dataProvider ?
	                        dataProvider.getItemAt(index) :
	                        null;
	        dispatchEvent(newEvent);
	    
	        event.stopImmediatePropagation();
    	}
    	
    	override public function set dataProvider(value:Object):void
    	{
    		// Always force the use of SelectableBusinessValueObjectCollection
    		// which will usually come through wrapped in an ArrayCollection
    		if (value is ArrayCollection) value = value.source;
    		
    		// Test to see whether the new dp value is the same as the one currently stored
    		// We need to extract the SelectableBusinessValueObjectCollection out of
    		// the dp first though.
			var dpTest:Object = dataProvider;
    		if (dataProvider is ArrayCollection) dpTest = (dataProvider as ArrayCollection).source;
    		if (value == dpTest) return;
    		
    		// We assume by this point the dataProvider is entirely new
    		super.dataProvider = value;
    	}
    	
    	override public function set selectedIndex(value:int):void
    	{
    		// Horrible hack to circumvent the silly code that doesn't set the
    		// selectedIndex inside NavBar till commitProperties time. We NEED to set it
    		// immediately so we have to force a call to commiteProps and then set
    		// the selectedIndex again just to ensure it runs a proper invalidation routine.
    		super.selectedIndex = value;
    		commitProperties();
    		super.selectedIndex = value;
    		
    		// Force an updateDisplayList so the selected index is updated visually
    		invalidateDisplayList();
    	}
    	
	}
}