<cfif isdefined("action") and action is "saveMap">
	
	<cfinsert datasource="#siteDataSource#" tablename="tcPic" formfields="created,textPadding,textWeight,textStyle,messageBackColor,borderRad,messageWidth,messageHeight,messageOpacity,fontIn,tc,mapName,imgZoom,imgCent,messageIn,textSize,topDist,leftDist,dateIn,mapType,colorIn">
	<cflocation url="mapList.cfm?message=<font color=green>Picture Added</font>&tcIn=#tc#">
	
</cfif>

<cfparam name="tcIn" default="1">
<cfparam name="zoomIn" default="8">
<cfparam name="zoomMax" default="9">
<cfparam name="centerIn" default="23.46554231775475, -77.37963867187">
<cfparam name="dateIn" default="2012-07-09">
<cfparam name="mapType" default="1">
<cfparam name="urlIn" default="http://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_TrueColor">
<cfparam name="fontIn" default="Coda Caption">

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
        <title>App</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="/favicon.ico">
		<link rel="stylesheet" href="spectrum.css" />
        <link rel="stylesheet" href="../styles/styles.css"/>
        <script src="../scripts/vendor/modernizr.js"></script>
		
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=<cfoutput>#fontIn#</cfoutput>">
		<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
		<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
		<script src="spectrum.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js"></script>
	
	<style>
	#messageSpan {
		position: absolute;
		font-family:'Coda Caption',serif;
		font-weight: 'normal';
		font-size: 60px;
		font-style: none;
		color: #ffffff;
		opacity: 1.0;
		padding: 10px;
	}	
	</style>

    </head>
    <body>
          <header>
            <div class="container">
                <div class="logo">
                    <a href="/">
                        <img src="../images/logo.png" alt="Yorb.it" title="Yorb.it Logo" />
                    </a>
                </div>
                <div class="navigation-button">
                    <img src="../images/menu_button.png" />
                </div>
            </div>
        </header>
		<div class="container">
            <div class="application">
            <div id="containerDiv"> 
			  <div id="mapDiv" title="mapDiv"  class="map-holder"></div>
			  <div id="messageDiv" title="messageDiv" onMouseUp="$('#topDist').val($('#messageDiv').css('top');"><span id="messageSpan" title="messageSpan"></span></div>
			</div>
			<!--
                <div class="map-holder">

                </div>
                -->
                <div class="tools">
                    <form action="GIBSmap.cfm?action=saveMap" method="post">
						<input type="hidden" name="topDist" id="topDist" size="3" min="0" max="600" step="10" value="0" onChange="$('#messageDiv').css('top',$('#topDist').val());">
						<input type="hidden" name="leftDist" id="leftDist" size="3" min="0" max="600" step="10" value="0" onChange="$('#messageDiv').css('left',$('#leftDist').val());">
						<input type="hidden" name="textWeight" id="textWeight">
						<input type="hidden" name="textStyle" id="textStyle">
						<cfoutput> 
						  <input type="hidden" name="user" value="#session.user#">
						  <input type="hidden" name="created" value="#now()#">
						  <input type="hidden" id="imgZoom" name="imgZoom" value="">
						  <input type="hidden" id="imgCent" name="imgCent" value="">
						  <input type="hidden" name="dateIn" value="#dateIn#">
						  <input type="hidden" name="mapType" value="#mapType#">
						</cfoutput>

                        <div class="item type">
                            <div class="title">
                                Type
                                <div class="icon"></div>
                            </div>
                            <div class="content">
                                <div class="row1">
                                    <div class="buttons">
                                        <div class="button active" data="regular" >
                                            Regular
                                        </div>
                                        <div class="button" data="bold" onClick="$('#messageSpan').css('text-weight','bold'); $('#textWeight').val('bold');">
                                            Bold
                                        </div>
                                        <div class="button" data="italic" onClick="$('#messageSpan').css('text-style','italics'); $('#textStyle').val('italics');">
                                            Italic
                                        </div>
                                    </div>
                                </div>
                                <div class="row2">
                                    <div class="button-group">
                                        <div class="button left active" data="left-aligned"></div>
                                        <div class="button center" data="center-aligned"></div>
                                        <div class="button right" data="right-aligned"></div>
                                    </div>
                                    <div class="color-select">

                                    </div>
                                </div>
                                <div class="row3">
                                    <div class="slider-group">
                                        <div class="label left">A</div>
                                        <div class="bar_slider"></div>
                                        <input type="hidden" name="textSize" id="textSize" />
                                        <div class="label right">A</div>
                                    </div>
                                </div>
                                <div class="row4">
                                    <textarea name="messageIn" id="messageIn" placeholder="Please type here to edit your text." onChange="$('#messageDiv').css('visibility','visible'); $('#messageSpan').text($('#messageIn').val());"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="item objects">
                            <div class="title">
                                Objects
                                <div class="icon"></div>
                            </div>
                            <div class="content">
                                <div class="row1">
                                    <div class="square"></div>
                                    <div class="circle"></div>
                                    <div class="buttons">
                                        <div class="button delete">
                                            Delete
                                        </div>
                                        <div class="button color-picker"></div>
                                    </div>
                                </div>
                                <div class="row2">
                                    <div class="slider-group width">
                                        <div class="label left"></div>
                                        <div class="bar_slider"></div>
                                        <div class="label right"></div>
                                    </div>
                                    <div class="slider-group height">
                                        <div class="label left"></div>
                                        <div class="bar_slider"></div>
                                        <div class="label right"></div>
                                    </div>
                                    <div class="slider-group scale">
                                        <div class="label left"></div>
                                        <div class="bar_slider"></div>
                                        <div class="label right"></div>
                                    </div>
                                    <div class="slider-group opacity">
                                        <div class="label left"></div>
                                        <div class="bar_slider"></div>
                                        <div class="label right"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="btn btn-primary btn-skinny pull-right">Save &amp; Publish</div>
                        <!--
                        <div class="item patterns active">
                            <div class="title">
                                Patterns
                                <div class="icon"></div>
                            </div>
                            <div class="content">
                                <div class="row1">
                                    <div class="square circles"></div>
                                    <div class="square squares"></div>
                                    <div class="square stripes"></div>
                                </div>
                                <div class="row3">
                                    <div class="slider-group opacity">
                                        <div class="label left"></div>
                                        <div class="bar_slider"></div>
                                        <div class="label right"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    -->
                    </form>
                </div>
            </div>
        </div>


        <script src="../scripts/vendor.js"></script>

        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
        <script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','UA-XXXXX-X');ga('send','pageview');
        </script>



        <script src="../scripts/scripts.js"></script>
        <script src='spectrum.js'></script>
        <script src="http://maps.google.com/maps/api/js?sensor=false"></script>
		
		<cfoutput> 

			<script>
			$(function() {
			     var mapOptions = {
			         center: new google.maps.LatLng(#centerIn#),
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
				 
				 //jQueryUI
				 $( "##messageDiv" ).draggable({stop: function( event, ui ) {$("##topDist").val(ui.position.top); $("##leftDist").val(ui.position.left);}
				 });
			 	 
				 //color picker
				 $("##colorIn").spectrum({color: "##00f"});
				 
				 //color picker
				 $("##messageBackColor").spectrum({color: "##00f"});				 
				 
			 })			 
			</script>
		</cfoutput> 
</body>
</html>
<!--

</head>

<body>
<div id="containerDiv"> 
  <div id="mapDiv" title="mapDiv"></div>
  <div id="messageDiv" title="messageDiv" onMouseUp="$('#topDist').val($('#messageDiv').css('top');"><span id="messageSpan"></span></div>
</div>
<div id="settingsDiv" title="settingsDiv"> 
  <form action="GIBSmap.cfm?action=saveMap" method="post">
		<input type="hidden" name="topDist" id="topDist" size="3" min="0" max="600" step="10" value="0" onChange="$('#messageDiv').css('top',$('#topDist').val());">
	    <input type="hidden" name="leftDist" id="leftDist" size="3" min="0" max="600" step="10" value="0" onChange="$('#messageDiv').css('left',$('#leftDist').val());">
    	<input type="hidden" name="textWeight" id="textWeight">
    	<input type="hidden" name="textStyle" id="textStyle">		
	
	<cfoutput>
		<input type="hidden" name="created" value="#now()#">
		<input type="hidden" id="imgZoom" name="imgZoom" value="">
		<input type="hidden" id="imgCent" name="imgCent" value="">
		<input type="hidden" name="tc" value="#tcIn#">
		<input type="hidden" name="dateIn" value="#dateIn#">
		<input type="hidden" name="mapType" value="#mapType#">
    </cfoutput> 
	Map Name: <input type="text" name="mapName" id="mapName" size="50">
    <br> 
	   
    Message: <input type="text" name="messageIn" size="50" id="messageIn">
    Text Size: <input type="number" name="textSize" id="textSize" size="3" min="10" max="120" value="60" onChange="$('#messageSpan').css('font-size',$('#textSize').val()+'px');">
    Text Padding: <input type="number" name="textPadding" id="textPadding" size="3" min="0" max="100" value="10" onChange="$('#messageSpan').css('padding-top',$('#textPadding').val()+'px'); $('#messageSpan').css('padding-left',$('#textPadding').val()+'px');">	
    Text Color: <input type="text" name="colorIn" id="colorIn" onChange="$('#messageSpan').css('color',$('#colorIn').val());">
	Font: 
    <select name="fontIn" id="fontIn" onChange="WebFont.load({google: {families: [$('#fontIn').val()]}}); $('#messageSpan').css('font-family',$('#fontIn').val());">
      <option value="Coda Caption">Coda Caption</option>
      <option value="Cinzel">Cinzel</option>
      <option value="Nova Square">Nova Square</option>
    </select><br>
	<a href="#" onClick="$('#messageSpan').css('text-weight','bold'); $('#textWeight').val('bold');">Bold</a>&nbsp;&nbsp;&nbsp;
	<a href="#" onClick="$('#messageSpan').css('text-style','italics'); $('#textStyle').val('italics');">Italics</a>
	
	<br>
		
	Box Width: <input type="number" name="messageWidth" id="messageWidth" size="4" min="50" max="1000" value="400" step="10" onChange="$('#messageDiv').css('width',$('#messageWidth').val()+'px');">
    Box Height: <input type="number" name="messageHeight" id="messageHeight" size="4" min="50" max="800" value="300"  step="10" onChange="$('#messageDiv').css('height',$('#messageHeight').val()+'px');">		
    Box Opacity: <input type="number" name="messageOpacity" id="messageOpacity" size="3" min="0" max="1" value="1"  step=".1" onChange="$('#messageDiv').css('opacity',$('#messageOpacity').val());">			
	Box Radius: <input type="number" name="borderRad" id="borderRad" size="4" min="0" max="600" value="10"  step="10" onChange="$('#messageDiv').css('border-radius',$('#borderRad').val()+'px');">		    
    Box Color: <input type="text" name="messageBackColor" id="messageBackColor" onChange="$('#messageDiv').css('background-color',$('#messageBackColor').val());">
	
	<br>
	
    <a href="#" onClick="$('#messageDiv').css('visibility','visible'); $('#messageSpan').text($('#messageIn').val());">Apply 
    Text</a>
	<br>
	<a href="#" onClick="$('#messageDiv').css('visibility','hidden');">Adjust Map</a>
	<br>

	
    <input type="submit" value="Save Map">
  </form>
</div>


</body>
</html>
-->