package com.layerglue.lib.base.collections.strategies 
{

	/**
	 * @author Jamie Copeland
	 */
	public interface IDictionaryStrategy extends ISimpleCollectionStrategy
	{
		function get keyPropertyName():String
		function set keyPropertyName(value:String):void
		
		function getItem(collection:Object, id:*):*
	}
}
