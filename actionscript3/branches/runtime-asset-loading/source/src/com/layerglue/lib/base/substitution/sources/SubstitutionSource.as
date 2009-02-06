package com.layerglue.lib.base.substitution.sources
{
	import com.layerglue.lib.base.collections.HashMap;
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	import com.layerglue.lib.base.utils.ArrayUtils;
	
	/**
	 * <p>A base class for Substitution sources.</p>
	 */
	public class SubstitutionSource extends Object implements ISubstitutionSource
	{
		public static const STRING_REF:String = "str";
		public static const NUMBER_REF:String = "num";
		public static const INT_REF:String = "int";
		public static const UINT_REF:String = "uint";
		public static const BOOLEAN_REF:String = "bool";
		
		private var _map:HashMap;
		private var _references:Array;
		
		public function SubstitutionSource()
		{
			super();
			
			_references = [];
			_map = new HashMap();
		}
		
		/**
		 * Repopulates the references list with the keys of the _map 
		 */
		protected function refreshReferencesList():void
		{
			ArrayUtils.removeAllItems(_references);
			
			for (var ref:* in _map.items)
			{
				_references.push(ref);
			}
		}
		
		protected function clearMap():void
		{
			_map.clear();
		}
		
		protected function clearReferences():void
		{
			ArrayUtils.removeAllItems(_references);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getValueByReference(ref:*):*
		{
			return _map.get(ref);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getReferences():Array
		{
			return _references;
		}
		
		public function addItem(id:*, value:*, type:String=null):void
		{
			var typedValue:* = getTypedValue(value, type);
			
			_map.put(id, typedValue);
			
			var keyIndex:int = _references.indexOf(id)
			
			if(keyIndex == -1)
			{
				_references.push(id);
			}
			else
			{
				_references[keyIndex] = id;
			}
		}
		
		public function removeItem(id:*):void
		{
			delete _map[id];
			ArrayUtils.removeItem(_references, id);
		}
		
		public function containsItem(id:*):Boolean
		{
			return !!_map.get(id);
		}
		
		protected function getTypedValue(value:*, typeReference:String):*
		{
			switch(typeReference)
			{
				case STRING_REF:
					var str:String = value;
					return str;
				break;
				
				case NUMBER_REF:
					var num:Number = value;
					return num
				break;
				
				case INT_REF:
					var int:int = value;
					return int;
				break;
				
				case UINT_REF:
					var uint:uint = value;
					return uint;
				break;
				
				case BOOLEAN_REF:
					var bool:Boolean = (value.toString() == "1" || value.toString() == "true");
					return bool;
				break;
			}
			
			return value;
		}
		
	}
}