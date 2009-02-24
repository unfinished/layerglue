package com.layerglue.flash.styles
{
	public class LGStyleManager
	{
		private static var _instance:LGStyleManager;
		
		public function LGStyleManager()
		{
			if (_instance != null)
			{
				throw new Error("Singleton instantiation");
			}
			_instance = this;
		}
		
		public static function getInstance():LGStyleManager
		{
			if (_instance == null)
			{
				_instance = new LGStyleManager();
			}
			return _instance;
		}
	}
}