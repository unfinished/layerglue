package com.layerglue.lib.base.command.commands
{
	import com.layerglue.lib.base.command.requests.IRequest;
	
	/**
	 * This class is the abstract base for commands that are triggered by requests via the connector.
	 */
	public class AbstractCommand implements ICommand
	{
		public function AbstractCommand()
		{
			super();
		}
		
		private var _request:IRequest;
		
		/**
		 * @inheritDoc
		 */
		public function get request():IRequest
		{
			return _request;
		}

		public function set request(value:IRequest):void
		{
			_request = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function execute(request:IRequest):void
		{
			this.request = request;
		}
	}
}