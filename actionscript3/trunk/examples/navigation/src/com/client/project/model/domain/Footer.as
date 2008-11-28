package com.client.project.model.domain
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Bindable]
	public class Footer extends EventDispatcher
	{
		public var copyright:String;
		
		public function Footer(target:IEventDispatcher=null)
		{
			super(target);
		}
		
	}
}