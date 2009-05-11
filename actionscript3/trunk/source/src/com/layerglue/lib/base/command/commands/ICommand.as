package com.layerglue.lib.base.command.commands
{
	import com.layerglue.lib.base.command.requests.IRequest;

	/**
	 * An interface to be implemented by all commands triggered by the request-command connector system.
	 */
	public interface ICommand
	{
		/**
		 * The request instance that triggered this command.
		 */
		function get request():IRequest
		function set request(value:IRequest):void
		
		/**
		 * The method called by connector when the command is triggered by the connector. All class
		 * functionality should either be contained in or initialized by this method.
		 */
		function execute(request:IRequest):void
	}
}