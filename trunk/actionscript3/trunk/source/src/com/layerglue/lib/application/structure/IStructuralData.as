package com.layerglue.lib.application.structure
{
	import com.layerglue.lib.base.collections.SelectableBusinessValueObjectCollection;
	import com.layerglue.lib.base.maps.IMapable;
	import com.layerglue.lib.base.models.vos.IBusinessValueObject;
	import com.layerglue.lib.application.navigation.INavigable;
	
	[Bindable]
	public interface IStructuralData extends
		IBusinessValueObject, 
		INavigable,
		IMapable
	{
		
		function get title():String;
		function set title(value:String):void
		
		function get children():SelectableBusinessValueObjectCollection
		function set children(value:SelectableBusinessValueObjectCollection):void
		
		function get defaultChildId():String
		function set defaultChildId(value:String):void
		
		function get defaultChild():IStructuralData
		
		function get parent():IStructuralData
		function set parent(value:IStructuralData):void
		
		function get selectedChild():IStructuralData
		function set selectedChild(value:IStructuralData):void
		
		function get selected():Boolean
		function set selected(value:Boolean):void
		
		function get uriNode():String
		function set uriNode(value:String):void
		
		function get depth():uint
		
		function get deserialized():Boolean
		function set deserialized(value:Boolean):void
		
		function get branchOnly():Boolean
		function set branchOnly(value:Boolean):void
		
		function isRoot():Boolean
		
		function deselect():void;
		
		function getChildByUriNode(nodeName:String):IStructuralData
	}
}