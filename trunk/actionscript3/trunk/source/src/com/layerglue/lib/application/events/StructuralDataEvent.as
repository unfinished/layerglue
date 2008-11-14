package com.layerglue.lib.application.events
{
	import flash.events.Event;

	public class StructuralDataEvent extends Event
	{
		/**
		 * Dispatched when the contents of a StructuralData instance's children collection changes.
		 */
		public static const CHILDREN_CHANGE:String = "childrenChange";
		
		public function StructuralDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		//------------------------------------------------------------------------------------------
		
		/**
		 * Dispatched when the <code>selected</code> property of a StructuralData instance changes.
		 */
		public static const SELECTION_CHANGE:String = "selectionChange";
		
		/**
		 * Dispatched when a child of a StructuralData instance changes its selection state.
		 */
		public static const CHILD_SELECTION_CHANGE:String = "childSelectionChange";
	}
}