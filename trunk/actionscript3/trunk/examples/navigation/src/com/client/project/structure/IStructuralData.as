package com.client.project.structure
{
	import com.layerglue.lib.application.navigation.INavigable;
	import com.layerglue.lib.base.collections.SelectableBusinessValueObjectCollection;
	import com.layerglue.lib.base.maps.IMapable;
	import com.layerglue.lib.base.models.vos.IBusinessValueObject;
	
	[Bindable]
	// TODO: take a look at these interfaces and what they're prescribing
	public interface IStructuralData extends
		IBusinessValueObject, 
		INavigable,
		IMapable
	{
		
		function get title():String;
		function set title(value:String):void
		
		function get children():Array
		function set children(value:Array):void
		
		function get defaultChildId():String
		function set defaultChildId(id:String):void
		
		function get defaultChild():IStructuralData
		
		function get parent():IStructuralData
		function set parent(value:IStructuralData):void
		
		function get selectedChild():IStructuralData
		function set selectedChild(value:IStructuralData):void
		
		function get selectedChildIndex():int;
		function set selectedChildIndex(value:int):void
		
		function get selected():Boolean
		function set selected(value:Boolean):void
		
		function get uriNode():String
		function set uriNode(value:String):void
		
		function get depth():uint
		
		function get branchOnly():Boolean
		function set branchOnly(value:Boolean):void
		
		function isRoot():Boolean
		
		function deselect():void;
		
		function getChildByUriNode(nodeName:String):IStructuralData
		
	}
}