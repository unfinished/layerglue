package com.layerglue.lib.base.core
{
	/**
	 * An interface for items that can have selected sub items
	 * 
	 * @see ISelectable
	 */
	public interface ISubselectable
	{
		function get selectedItem():ISelectable
		function set selectedItem(value:ISelectable):void
	}
}