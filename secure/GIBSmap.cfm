<cfif isdefined("action") and action is "saveMap">
	
	<cfinsert datasource="#siteDataSource#" tablename="tcPic" formfields="user,created,textPadding,textWeight,textStyle,messageBackColor,borderRad,messageWidth,messageHeight,messageOpacity,fontIn,tc,mapName,imgZoom,imgCent,messageIn,textSize,topDist,leftDist,dateIn,mapType,colorIn">
	
	<cflocation url="mapList.cfm?message=<font color=green>Picture Added</font>">
	
</cfif>

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
<html>
    <head>
        <meta charset="utf-8">
        <title>App</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="/favicon.ico">
		<link rel="stylesheet" href="spectrum.css" />
        <link rel="stylesheet" href="../styles/styles.css"/>
        <script src="../scripts/vendor/modernizr.js"></script>
		
		<script src="http://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<!--- <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=<cfoutput>#fontIn#</cfoutput>"> --->
		<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>

    </head>
    <body>
<header> 
<div class="container"> 
  <div class="logo"> <a href="/"> <img src="../images/logo.png" alt="Yorb.it" title="Yorb.it Logo" /> 
    </a> </div>
  <div class="navigation-button"> <img src="../images/menu_button.png" /> </div>
</div>
</header> 
<div class="container"> 
  <div class="application"> 
    <div id="containerDiv"> 
      <div id="mapDiv" title="mapDiv"  class="map-holder"></div>
      <div id="messageDiv" title="messageDiv"><span id="messageSpan"></span></div>
    </div>
    <!--
                <div class="map-holder">

                </div>
                -->
    <div class="tools"> 
      <form action="GIBSmap.cfm?action=saveMap" method="post" id="form1" name="form1">
        <input type="hidden" name="topDist" id="topDist" size="3" min="0" max="600" step="10" value="0" onChange="$('#messageDiv').css('top',$('#topDist').val());">
        <input type="hidden" name="leftDist" id="leftDist" size="3" min="0" max="600" step="10" value="0" onChange="$('#messageDiv').css('left',$('#leftDist').val());">
        <input type="hidden" name="textWeight" id="textWeight" value="normal">
        <input type="hidden" name="textStyle" id="textStyle" value="normal">
        <input type="hidden" name="textSize" id="textSize" value="60">
        <input type="hidden" name="textAlign" id="textAlign" value="left">
        <input type="hidden" name="messageWidth" id="messageWidth" value="300">
        <input type="hidden" name="messageHeight" id="messageHeight" value="200">
		<input type="hidden" name="borderRad" id="borderRad" value="10">
		<input type="hidden" name="messageOpacity" id="messageOpacity" value="1">
        <cfoutput> 
          <input type="hidden" name="user" value="#session.user#">
          <input type="hidden" name="created" value="#now()#">
          <input type="hidden" id="imgZoom" name="imgZoom" value="">
          <input type="hidden" id="imgCent" name="imgCent" value="">
          <input type="hidden" id="dateIn" name="dateIn" value="#dateIn#">
          <input type="hidden" name="mapType" value="#mapType#">
        </cfoutput> 
        <div class="item type"> 
          <div class="title"> Type 
            <div class="icon"></div>
          </div>
          <div class="content"> 
            <div class="row1"> 
              <div class="buttons"> 
                <div class="button active" data="regular" onClick="$('#messageSpan').css('font-weight','normal'); $('#textWeight').val('normal'); $('#messageSpan').css('font-style','normal'); $('#textStyle').val('normal');"> 
                  Regular </div>
                <div class="button" data="bold" onClick="$('#messageSpan').css('font-weight','bold'); $('#textWeight').val('bold');"> 
                  Bold </div>
                <div class="button" data="italic" onClick="$('#messageSpan').css('font-style','italic'); $('#textStyle').val('italics');"> 
                  Italic </div>
              </div>
            </div>
            <div class="row2"> 
              <div class="button-group"> 
                <div class="button left active" data="left-aligned" onClick="$('#messageSpan').css('text-align','left'); $('#textAlign').val('left');"></div>
                <div class="button center" data="center-aligned" onClick="$('#messageSpan').css('text-align','center'); $('#textAlign').val('center');"></div>
                <div class="button right" data="right-aligned" onClick="$('#messageSpan').css('text-align','right'); $('#textAlign').val('right');"></div>
              </div>
              <div> 
                <input type="text" name="colorIn" id="colorIn" onChange="$('#messageSpan').css('color',$('#colorIn').val());">
              </div>
            </div>
            <div class="row3"> 
              <!--- text slider --->
              <div class="slider-group"> 
                <div class="label left">A</div>
                <div class="bar_slider"></div>
                <div class="label right">A</div>
              </div>
            </div>
            <div class="row4"> 
              <textarea name="messageIn" id="messageIn" placeholder="Please type here to edit your text." onChange="$('#messageDiv').css('visibility','visible'); $('#messageSpan').text($('#messageIn').val());"></textarea>
            </div>
          </div>
        </div>
        <div class="item objects"> 
          <div class="title"> Objects 
            <div class="icon"></div>
          </div>
          <div class="content"> 
            <div class="row1"> 
              <div class="square" onClick="$('#messageDiv').css({'visibility':'visible','background-color':'#000000'});"></div>
              <!--- <div class="circle" onClick="$('#messageDiv').css({'visibility':'visible','background-color':'#000000'}); var val1 =$('#messageDiv').attr('width'); var val2 = val1 / 2; $('#messageDiv').css('border-radius',val2+'px');"></div> --->
              <div class="buttons"> 
                <div onClick="$('#messageDiv').css('visibility','hidden');" class="button delete" > 
                  Delete </div>
                <div> 
                  <!--- box color removed class --->
                  <input type="text" name="messageBackColor" id="messageBackColor" onChange="$('#messageDiv').css('background-color',$('#messageBackColor').val());">
                </div>
              </div>
            </div>
            <div class="row2"> 
              <div class="slider-group width"> 
                <div class="label left"></div>
                <div class="bar_sliderW"></div>
                <div class="label right"></div>
              </div>
              <div class="slider-group height"> 
                <div class="label left"></div>
                <div class="bar_sliderH"></div>
                <div class="label right"></div>
              </div>
              <!---   <div class="slider-group scale">
                                        <div class="label left"></div>
                                        <div class="bar_slider"></div>
                                        <div class="label right"></div>
                      </div> --->
              <div class="slider-group opacity"> 
                <div class="label left"></div>
                <div class="bar_sliderO"></div>
                <div class="label right"></div>
              </div>
			  
			  <div class="slider-group border"> <!--- border Radius --->
                <div class="label left"></div>
                <div class="bar_sliderB"></div>
                <div class="label right"></div>
              </div>
            </div>
          </div>
        </div>
        <div class="btn btn-primary btn-skinny pull-right" onClick="$('#form1').submit();">Save &amp; Publish</div>
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