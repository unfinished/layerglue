package com.layerglue.lib.base.substitution.sources
{
	import com.layerglue.lib.base.substitution.ISubstitutionSource;
	import com.layerglue.lib.base.utils.ArrayUtils;

	public class MultiSubstitutionSource extends Object implements ISubstitutionSource
	{
		private var _sources:Array;
		
		public function MultiSubstitutionSource(sources:Array=null)
		{
			super();
			
			_sources = sources ? sources : new Array();
		}
		
		public function addItem(source:ISubstitutionSource):void
		{
			_sources.push(source);
		}
		
		public function removeItem(source:ISubstitutionSource):void
		{
			ArrayUtils.removeItem(_sources, source);
		}
		
		public function getValue(key:*):*
		{
			var source:ISubstitutionSource;
			for each(source in _sources)
			{
				var value:* = source.getValue(key);
				if(value)
				{
					return value;
				}
			}
			
			return null;
		}
		
		public function getReferences():Array
		{
			var refs:Array = [];
			var source:ISubstitutionSource;
			for each(source in _sources)
			{
				refs = refs.concat(source.getReferences());
			}
			return refs;
		}
		
	}
}