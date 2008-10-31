package com.layerglue.lib.base.requests
{
	/**
	 * An interface to be implemented by all requests used to trigger commands by the request-command
	 * system. 
	 */
	public interface IRequest
	{
		/**
		 * The implementation of this should dispatch this method through the RequestCommandConnector.
		 */
		function dispatch():void;
	}
}