package com.layerglue.lib.application.structure
{
	import com.layerglue.lib.application.navigation.INavigable;
	import com.layerglue.lib.base.collections.ICollection;
	
	// TODO: take a look at these interfaces and what they're prescribing
	public interface IStructuralData extends INavigable
	{
		[Bindable(event="propertyChange")]
		function get id():String;
		function set id(value:String):void
		
		[Bindable(event="propertyChange")]
		function get title():String;
		function set title(value:String):void
		
		[Bindable(event="propertyChange")]
		function get children():ICollection
		function set children(value:ICollection):void
		
		[Bindable(event="propertyChange")]
		function get defaultChildId():String
		function set defaultChildId(id:String):void
		
		[Bindable(event="propertyChange")]
		function get defaultChild():IStructuralData
		
		[Bindable(event="propertyChange")]
		function get parent():IStructuralData
		function set parent(value:IStructuralData):void
		
		[Bindable(event="childSelectionChange")]
		function get selectedChild():IStructuralData
		function set selectedChild(value:IStructuralData):void
		
		[Bindable(event="childSelectionChange")]
		function get selectedChildIndex():int;
		function set selectedChildIndex(value:int):void
		
		[Bindable(event="selectionChange")]
		function get selected():Boolean
		function set selected(value:Boolean):void
		
		[Bindable(event="propertyChange")]
		function get uriNode():String
		function set uriNode(value:String):void
		
		[Bindable(event="propertyChange")]
		function get depth():uint
		
		[Bindable(event="propertyChange")]
		function get branchOnly():Boolean
		function set branchOnly(value:Boolean):void
		
		function get structuralDataToControllerMapId():String
		function set structuralDataToControllerMapId(value:String):void
		
		function get controllerToViewMapId():String
		function set controllerToViewMapId(value:String):void
		
		function isRoot():Boolean
		
		function getChildById(id:String):IStructuralData
		function getChildByUriNode(nodeName:String):IStructuralData
		function getChildAt(index:int):IStructuralData
		
	}
}