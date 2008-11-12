package com.client.project.temp
{
	import com.layerglue.lib.base.notifiication.Notifier;

	public class TraceNotifier extends Notifier
	{
		public function TraceNotifier()
		{
			super();
		}
		
		private static var _instance:TraceNotifier;
		
		public static function getInstance():TraceNotifier
		{
			if(!_instance)
			{
				_instance = new TraceNotifier;
			}
			
			return _instance;
		}
		
	}
}