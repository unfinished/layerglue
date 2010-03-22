package com.layerglue.lib.base.resources 
{

	/**
	 * @author Jamie Copeland
	 */
	public interface IRemoteResourceItem extends IResourceItem 
	{
		function get url():String;
		function set url(value:String):void;
	}
}
