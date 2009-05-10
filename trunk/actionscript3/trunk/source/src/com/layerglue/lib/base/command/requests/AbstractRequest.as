package com.layerglue.lib.base.command.requests
{
	import com.layerglue.lib.base.command.FrontController;

	/**
	 * This class is the abstract base for requests that can be used trigger commands through via
	 * the connector.  
	 */
	public class AbstractRequest extends Object implements IRequest
	{
		public function AbstractRequest()
		{
			super();
		}
		
		/**
		 * Dispatches the request via the RequestCommandConnector
		 */
		public function dispatch():void
		{
			FrontController.getInstance().dispatchRequest(this);
		}
	}
}