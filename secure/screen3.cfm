<cfset siteDataSource = "yorbitDB"> 

<cfquery datasource="#siteDataSource#" name="getData">
	select * from tcpic where refnum = #mapIn#
</cfquery>

<cfparam name="zoomIn" default="#getData.imgZoom#">
<cfparam name="zoomMax" default="9">
<cfparam name="centerIn" default="#getData.imgCent#">
<cfparam name="dateIn" default="#getData.dateIn#">
<cfparam name="mapType" default="#getData.mapType#">
<cfparam name="fontIn" default="#getData.fontIn#">

<cfif mapType is 1>
<cfset urlIn = "http://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_TrueColor">
<cfset googleLevel = "GoogleMapsCompatible_Level9">
<cfset zoomMax = 9>
<cfset mapTypeName = "MODIS_Terra_CorrectedReflectance_TrueColor">
</cfif>

<cfif mapType is 2>
<cfset urlIn = "http://map1.vis.earthdata.nasa.gov/wmts-webmerc/VIIRS_CityLights_2012">
<cfset googleLevel = "GoogleMapsCompatible_Level8">
<cfset zoomMax = 8>
<cfset mapTypeName = "VIIRS_CityLights_2012">
</cfif>

<cfif mapType is 3>
<cfset urlIn = "http://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Aqua_SurfaceReflectance_Bands121">
<cfset googleLevel = "GoogleMapsCompatible_Level9">
<cfset zoomMax = 9>
<cfset mapTypeName = "MODIS_Aqua_SurfaceReflectance_Bands121">
</cfif>

<!doctype html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title>View and share your map | Yorbit</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="/images/favicon.ico">
        <link rel="apple-touch-icon" href="/images/apple-touch-icon.png" />
		<link rel="apple-touch-icon" sizes="57x57" href="/images/apple-touch-icon-57x57.png" />
		<link rel="apple-touch-icon" sizes="72x72" href="/images/apple-touch-icon-72x72.png" />
		<link rel="apple-touch-icon" sizes="76x76" href="/images/apple-touch-icon-76x76.png" />
		<link rel="apple-touch-icon" sizes="114x114" href="/images/apple-touch-icon-114x114.png" />
		<link rel="apple-touch-icon" sizes="120x120" href="/images/apple-touch-icon-120x120.png" />
		<link rel="apple-touch-icon" sizes="144x144" href="/images/apple-touch-icon-144x144.png" />
		<link rel="apple-touch-icon" sizes="152x152" href="/images/apple-touch-icon-152x152.png" />
        <link rel="stylesheet" href="../styles/styles.css"/>
        <script src="../scripts/vendor/modernizr.js"></script>		
		<!--<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=<cfoutput>#fontIn#</cfoutput>">-->
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
		<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<style>

#mapDiv{
	position: absolute;
	top:0px;
	left:0px;
	z-index:1;
	width:625px;
	height:625px;

}

#mapInfo{
	position: absolute;
	top:20px;
	left:20px;
	z-index:3;
	width:250px;
	height:100px;
	font-size:14px;
	color: #ffffff;
	padding: 20px;
	visibility:hidden;
	border-radius: 20px;
	background-color: #000000;
	opacity: 0.5;
}

</style>
<cfoutput> 
  <style>
##messageDiv{
	position: absolute;
	top:#getData.topDist#px;
	left:#getData.leftDist#px;
	z-index:2;
	width:#getData.messageWidth#px;
	height:#getData.messageHeight#px;
	padding:10px;
	visibility:visible;
	background-color: #getData.messageBackColor#;
	opacity: #getData.messageOpacity#;	
}

##messageSpan {
	position: absolute;
	font-family:'#fontIn#', 'Source Sans Pro', serif;
	font-weight: 'normal';
	font-size:#getData.textSize#px;
	font-style: none;
	color: #getData.colorIn#;
	opacity: #getData.messageOpacity#;
	padding: #getData.textPadding#;
	font-weight:#getData.textWeight#;
	font-style:#getData.textStyle#;
	border-radius: #getData.borderRad#px;
}
</style>

</cfoutput> 
<cfset centerOut = replacelist(centerIn,"(,)",",")>
<cfoutput> 
  <script>
$(function() {
     var mapOptions = {
         center: new google.maps.LatLng(#centerOut#),
         zoom: #zoomIn#,
         maxZoom: #zoomMax#,
		 panControl:false,
		 zoomControl:false,
		 mapTypeControl:false,
		 scaleControl:false,
		 streetViewControl:false,
		 overviewMapControl:false,
		 rotateControl:false
     };
 
     var map = new google.maps.Map(document.getElementById("mapDiv"), mapOptions);	 
	 
     var getTileUrl = function(tile, zoom) {	  	
		$("##imgZoom").val(zoom);
		$("##imgCent").val(map.center);
		
         return "#urlIn#/default/#dateIn#/" +
                "#googleLevel#/" +  //EPSG4326_250m
                 zoom + "/" + tile.y + "/" +
                 tile.x + ".jpg";
     };
 
     var layerOptions = {
         alt: "MODIS_Terra_Aerosol",
         getTileUrl: getTileUrl,
         maxZoom: #zoomMax#,
         minZoom: 1,
         name: "MODIS_Terra_Aerosol",
         tileSize: new google.maps.Size(256,256),
         opacity: 1.0
     };
 
     var imageMapType = new google.maps.ImageMapType(layerOptions);
     map.overlayMapTypes.insertAt(0, imageMapType);
	 
 })
 
</script>
</cfoutput> 
    </head>
    <body>
<!--[if lt IE 10]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
<header> 
	<div class="container"> 
		<div class="logo">
			<a href="/">
				<img src="/images/logo.png" alt="Yorb.it" title="Yorb.it Logo" /> 
			</a>
		</div>
		<div class="navigation-button" id="trigger-overlay">
			<img src="/images/menu_button.png" /> 
		</div>
	</div>
</header> 
<div class="overlay overlay-door">
    <div class="close_button">
        <a href="#" class="close_navigation overlay-close" onclick="return false;">X</a>
    </div>
    <nav class="navigation">
        <ul>					
            <li><a href="screen1.cfm">Add your own earth art</a></li>
            <li><a href="maplist.cfm?logout=true">Log out</a></li>
			<li><a href="/">How Does it Work</a></li>
        </ul>
    </nav>
</div>
<div class="container"> 
  <div class="application"> 
	<div class="map-holder"> 
	  <div id="mapDiv" title="mapDiv"></div>
	  <div id="messageDiv"><span id="messageSpan" class="messageSpan"><cfoutput>#getData.messageIn#</cfoutput></span></div>
	  <div id="mapInfo"> <cfoutput> Image Date: #getData.dateIn#<br>
		  Center: #getData.imgCent#<br>
		  Map Type<br>
		  #mapTypeName# </cfoutput> </div>
	</div>
	<div class="tools"> 
	  <div class="share"> 
		<p>Share your art. Place a link on Facebook or Twitter, or email the Link 
		  to a friend.</p>
		  <input type="text" class="map-link" value="http://www.yorb.it/viewart.cfm?artIn=<cfoutput>#mapIn#</cfoutput>" />
		  <a href="#" class="btn btn-skinny btn-block btn-primary" id="share-now">Share</a>
		  <a href="screen1.cfm" class="btn btn-skinny btn-block btn-primary">Make a New Map</a>
		  <a href="maplist.cfm" class="btn btn-skinny btn-block btn-primary">View map list</a>
		</div>
	</div>
  </div>
</div>

<div class="share-overlay">
    <div class="close_button">
        <a href="#" class="close_navigation">X</a>
    </div>
    <div class="container">
        <!-- AddThis Button BEGIN -->
        <div class="addthis_toolbox">
            <a class="addthis_button_facebook">
                <img src="/images/social_facebook.png" alt="Share" />
            </a>
            <a class="addthis_button_twitter">
                <img src="/images/social_twitter.png" alt="Share" />
            </a>
            <a class="addthis_button_tumblr">
                <img src="/images/social_tumblr.png" alt="Share" />
            </a>
            <a class="addthis_button_email">
                <img src="/images/social_email.png" alt="Share" />
            </a>
        </div>
        <script type="text/javascript">
        	var shareURL = 'http://www.yorb.it/viewart.cfm?artIn=<cfoutput>#mapIn#</cfoutput>';
	        var addthis_config = {'data_track_addressbar':false};
	        var addthis_share = {
		        url:shareURL,
		        title:'Map Creation with Yorbit',
		        description:'View the map that I created with Yorbit (http://yorb.it)',
		        templates:{
			        twitter:'Check out the map that I made on Yorbit. {{url}}'
		        }
	        };
        </script>	
        <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-522f3ece441fe376"></script>
        <!-- AddThis Button END -->
    </div>
</div>


        <script src="../scripts/vendor.js"></script>
        <script src="../scripts/scripts.js"></script>
</body>
</html>
