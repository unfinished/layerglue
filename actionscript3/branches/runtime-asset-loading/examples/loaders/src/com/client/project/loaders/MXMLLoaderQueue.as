package com.client.project.loaders
{
	import com.layerglue.lib.base.events.loader.MultiLoaderEvent;
	import com.layerglue.lib.base.loaders.ILoader;
	import com.layerglue.lib.base.loaders.MultiLoader;
	
	import mx.core.IMXMLObject;
	
	[Event(name="itemComplete", type="com.layerglue.lib.base.events.loader.MultiLoaderEvent")]
	
	[DefaultProperty("loaders")]
	
	[Bindable]
	public class MXMLLoaderQueue extends MultiLoader implements IMXMLObject
	{
		public var id:String;
		
		[ArrayElementType("com.client.project.loaders.IMXMLLoader")]
		public function get loaders():Array
		{
			return _loaders;
		}
		public function set loaders(value:Array):void
		{
			for each (var loader:ILoader in value)
			{
				addItem(loader);
			}
		}
		
		public function MXMLLoaderQueue()
		{
			super();
		}
		
		public function initialized(document:Object, id:String):void
		{
			this.id = id;
		}
		
	}
}