package com.layerglue.lib.base.loaders
{
	import flash.events.IEventDispatcher;

	//[Event(name="open", type="")] //Event.OPEN 
	//[Event(name="complete", type="")] //Event.COMPLETE
	//[Event(name="progress", type="")] //ProgressEvent.PROGRESS

	/**
	 * Defines the methods necessary to be a simple loader
	 * 
	 * @see IMultiLoader, AbstractLoader, MultiLoader
	 */
	public interface ILoader extends IEventDispatcher
	{
		/**
		 * Starts the download.
		 */
		function open():void
		
		/**
		 * Stops the download.
		 */
		function close():void
		
		/**
		 * Whether or not the load has completed.
		 * 
		 * @returns A boolean describing whether or not he load has completed.
		 */
		function isComplete():Boolean		
	}
}