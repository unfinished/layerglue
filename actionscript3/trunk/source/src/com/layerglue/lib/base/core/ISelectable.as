package com.layerglue.lib.base.core
{
	/**
	 * An interface to implement when a class needs to be selectable.
	 * 
	 * @see ISubselectable
	 */
	public interface ISelectable
	{
		/**
		 * Whether or not an instance is selected
		 * 
		 * @returns A boolean signifying whether or not this instance is selected.
		 */
		function get selected():Boolean;
		function set selected(value:Boolean):void;
	}
}