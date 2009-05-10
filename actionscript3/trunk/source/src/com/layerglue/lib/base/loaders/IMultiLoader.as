package com.layerglue.lib.base.loaders
{
	import flash.events.IEventDispatcher;

	/**
	 * Defines the methods necessary for creating a class capable of loading multiple sub loaders
	 * 
	 * @see MultiLoader
	 */
	public interface IMultiLoader extends IEventDispatcher, ILoader
	{
		function addItem(item:ILoader):void
		function addItemAt(item:ILoader, index:uint):void
		function removeItem(item:ILoader):void
		function removeItemAt(index:uint):void
		function removeAllItems():void
		function getItemAt(index:uint):ILoader
		//function open(reloadAll:Boolean=false):void // TODO look into how to doing a reloadAll
		function get currentIndex():uint
		function get currentItem():ILoader
		
		function hasNext():Boolean
		function loadNext():void
		
	}
}