package com.layerglue.lib.application.maps
{
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.utils.ReflectionUtils;
	import com.layerglue.lib.application.controllers.IController;

	public class ClassMap extends Object
	{
		private var _idMap:HashMap;
		private var _classRefMap:HashMap;
		
		public function ClassMap()
		{
			super();
			
			_idMap = new HashMap();
			_classRefMap = new HashMap();
		}
		
		public function addIdMapping(id:String, viewClassReference:Class):void
		{
			_idMap.put(id, viewClassReference);
		}
		
		public function addClassReferenceMapping(controllerClassReference:Class, viewClassReference:Class):void
		{
			_classRefMap.put(controllerClassReference, viewClassReference);
		}
		
		public function getFromIdMap(id:String):Class
		{
			return _idMap.get(id);
		}
		
		public function getFromClassReferenceMap(classReferece:Class):Class
		{
			return _classRefMap.get(classReferece);
		}
	}
}