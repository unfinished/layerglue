package com.client.project.maps
{
	import com.client.project.controllers.ArtistController;
	import com.client.project.controllers.ContactController;
	import com.client.project.controllers.GalleryController;
	import com.client.project.controllers.HomeController;
	import com.client.project.controllers.ImageController;
	import com.client.project.controllers.SiteController;
	import com.client.project.view.ArtistView;
	import com.client.project.view.ContactView;
	import com.client.project.view.GalleryView;
	import com.client.project.view.HomeView;
	import com.client.project.view.ImageView;
	import com.client.project.view.SiteView;
	import com.layerglue.lib.application.maps.ControllerToViewMap;

	public class ProjectControllerToViewMap extends ControllerToViewMap
	{
		public function ProjectControllerToViewMap()
		{
			super();
			
			addClassReferenceMapping(SiteController, SiteView);
			addClassReferenceMapping(HomeController, HomeView);
			addClassReferenceMapping(GalleryController, GalleryView);
			addClassReferenceMapping(ArtistController, ArtistView);
			addClassReferenceMapping(ImageController, ImageView);
			addClassReferenceMapping(ContactController, ContactView);
		}
		
	}
}