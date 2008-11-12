package com.client.project.temp
{
	import com.layerglue.lib.base.notifiication.Notification;

	public class Trace extends Notification
	{
		public static const TRACE:String = "trace";
		
		public var output:String;
		
		public static var totalOutput:String = "";
		public static var incrementer:int = 0;
		
		public function Trace(output:String)
		{
			super(TRACE);
			
			this.output = output;
			
			totalOutput += incrementer + ". " + output + "\n";
			
			incrementer++;
		}
		
	}
}