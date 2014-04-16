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
<html>
<head>
<title>Yorb.it Earth Art</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=<cfoutput>#fontIn#</cfoutput>">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>

<style>
#containerDiv{
	width:1200px;
	height:800px;
	margin-right:auto;
	margin-left:auto;
	border-radius: 20px;
	position:relative;
}

#mapDiv{
	position: absolute;
	top:0px;
	left:0px;
	z-index:1;
	width:1200px;
	height:800px;
	border-radius: 20px;
}

#settingsDiv{
	width:1200px;
	height:800px;
	margin-right:auto;
	margin-left:auto;
	border-radius: 20px;
	position:relative;
	margin-top:10px;
	z-index:3;
}

.liList {
	display:inline;
	padding:6px;
}

.liList a{
	color:#666666;
	font-size:24px;
	font-family:san-serif;
	text-decoration: none;
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
	padding: 10px;
	visibility:visible;
	border-radius: 20px;
	background-color: #getData.messageBackColor#;
	opacity: #getData.messageOpacity#;	
}

##messageSpan {
	position: absolute;
	font-family:'#fontIn#', serif;
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

<div id="containerDiv"> 
  <div id="mapDiv" title="mapDiv"></div>
  <div id="messageDiv" title="messageDiv" onMouseUp="$('#topDist').val($('#messageDiv').css('top');"><span id="messageSpan"><cfoutput>#getData.messageIn#</cfoutput></span></div>
  <div id="mapInfo"> <cfoutput> Image Date: #getData.dateIn#<br>
      Center: #getData.imgCent#<br>
      Map Type<br>
      #mapTypeName# </cfoutput> </div>
</div>

</body>
</html>