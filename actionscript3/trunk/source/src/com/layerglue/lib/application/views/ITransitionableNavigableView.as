package com.layerglue.lib.application.views
{
	public interface ITransitionableNavigableView extends INavigableView
	{
		function startTransitionIn():void
		function startTransitionOut():void
		function stopTransition():void;
	}
}