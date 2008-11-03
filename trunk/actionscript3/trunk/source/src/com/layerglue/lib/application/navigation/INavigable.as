package com.layerglue.lib.application.navigation
{
	import flash.events.IEventDispatcher;

	public interface INavigable extends IEventDispatcher
	{
		function get uri():String;
	}
}