<cfif isdefined("action") and action is "getAddress">
	<cfset addOut = #replace(location," ","+","all")#>
		
	<cfhttp method="get" url="http://maps.googleapis.com/maps/api/geocode/xml?address=#location#&sensor=true" result="getAdd"></cfhttp>
	<cfset mydoc = XmlParse(#getAdd.filecontent#)>
	<cfset latOut = mydoc.GeocodeResponse.result.geometry.location.lat.XMLText>
	<cfset longOut = mydoc.GeocodeResponse.result.geometry.location.lng.XMLText>
	<cflocation url="GIBSmap.cfm?zoomIn=7&centerIn=#latOut#,#longOut#&mapType=#mapType#&dateIn=#dateIn#">
	<cfabort>
</cfif>

<!doctype html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title>Search for your map | Yorbit</title>
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
        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <link rel="stylesheet" href="../styles/styles.css"/>
        <script src="../scripts/vendor/modernizr.js"></script>

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
  <div class="modal" id="modal1"> 
    <p>Choose a location on Earth: e.g. Bahamas or Sahara Desert </p>
    <form action="screen1.cfm?action=getAddress" method="post" id="form1">
      <input type="hidden" name="action" value="getAddress">
      <input type="text" class="location" id="location" name="location" placeholder="Location" />
      <input type="text" class="date" id="dateIn" name="dateIn" placeholder="Date" />
	  
      <div class="button-group map-type"> 
        <p>Seach maps by the following</p>
        <div class="button first" data="3"> Aqua </div>
        <div class="button" data="2">Night</div>
        <div class="button last active" data="1"> Reflect </div>
      </div>
	  
      <select class="hidden" id="mapType" name="mapType">
        <option value="1" selected>CorrectedReflectance_TrueColor</option>
        <option value="2">City Lights</option>
        <option value="3">MODIS_Aqua_SurfaceReflectance_Bands121</option>
      </select>
	  
	  <input type="submit" value="Proceed" class="btn btn-primary btn-skinny" style="float:right; margin-top:54px;">
    </form>
  </div>
</div>


    <script src="../scripts/vendor.js"></script>
    <script src="../scripts/scripts.js"></script>
</body>
</html>
