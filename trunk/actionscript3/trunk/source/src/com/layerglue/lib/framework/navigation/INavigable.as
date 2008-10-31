package com.layerglue.lib.framework.navigation
{
	import flash.events.IEventDispatcher;

	public interface INavigable extends IEventDispatcher
	{
		function get uri():String;
	}
}