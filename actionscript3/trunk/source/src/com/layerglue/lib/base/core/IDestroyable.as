package com.layerglue.lib.base.core
{
	/**
	 * <p>An interface to be used when a class has to perfom some functionality on destruction.</p>
	 * 
	 * <p>This commonly has two main uses:</p>
	 * <p>1. If a class needs to clean up internal values, listeners etc to ensure it can be
	 * garbage collected.</p>
	 * <p>2. It needs to dispatch an event or make a call to another class to inform a system that it
	 * is being destroyed.</p>
	 */
	public interface IDestroyable
	{
		function destroy():void
	}
}