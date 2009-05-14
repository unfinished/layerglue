package com.layerglue.lib.base.substitution
{
	import com.layerglue.lib.base.collections.IKeyValuePairCollection;
	
	/**
	 * <p>An interface to define an object that acts as a dictionary/hashmap to return values values
	 * relating to a certain reference or key.</p>
	 * 
	 * <p>For example, this interface is used by the ISubstitutor as a data source.</p>
	 */
	public interface ISubstitutionSource extends IKeyValuePairCollection
	{
		function getReferences():Array;
	}
}