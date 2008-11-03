package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.navigation.NavigationPacket;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.IView;
	
	public class ApplicationController extends AbstractNavigableController implements IApplicationController
	{
		
		protected static var _instance:ApplicationController;
		
		
		
		public static function getInstance():ApplicationController
		{
			return _instance;
		}
		
		public function ApplicationController(structuralData:IStructuralData, view:IView)
		{
			_instance = this;
			
			super();
			
			this.structuralData = structuralData;
			view.structuralData = structuralData;
			
			//this.view = view;
			
		}
		
		public function getControllerHierarchyStrand(packet:NavigationPacket):Array
		{
			//TODO Tidy this up and look at how packet.hasChildAtDepth(0) always returns false
			  
			var strand:Array = [];
			var controller:INavigableController = this;
			var depth:int = 1;
			
			//trace(">>>>>>>>>>>>>>>>>>>>>> getControllerHierarchyStrand: " + packet.uri);
			
			while(packet.hasChildAtDepth(depth))
			{
				controller = controller.getChildByUriNode(packet.getUriNodeStringAtDepth(depth));
				
				//Deals with 404 references returning null for the controller
				if(controller)
				{
					strand.push(controller);
					depth++;
				}
				else
				{
					break;
				}
				
			}
			strand.unshift(this);
			
			return strand
		}
		
		public function getCurrentControllerHierarchyStrand():Array
		{
			var strand:Array = [];
			var controller:IController = deepestSelectedChild;
			while(controller != this)
			{
				strand.push(controller);
				controller = controller.parent;
			}
			strand.push(this);
			strand.reverse();
			return strand;
		}
		
		public function getPageTitleFromPacket(packet:NavigationPacket):String
		{
			var title:String = "";
			var strand:Array = getControllerHierarchyStrand(packet)
			
			for(var i:int=0 ; i<strand.length ; i++)
			{
				var node:INavigableController = strand[i];
				
				//Conditional in place to stop 404s throwing error here - if there is a 404 we would
				//be trying to extract a title from a non-existent piece of structural data.
				if(node)
				{
					title = title + node.structuralData.title + (i < strand.length-1 ? " > " : "");
				}
			}
			
			return title;
		}
	}
}