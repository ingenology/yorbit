<!doctype html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title>Login | Yorbit</title>
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

        <link rel="stylesheet" href="styles/styles.css">

        <script src="scripts/vendor/modernizr.js"></script>


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
	                <li><a href="/">Home</a></li>					
                    <li><a href="screen1.cfm">Add your own earth art</a></li>
                    <li><a href="maplist.cfm?logout=true">Log out</a></li>
					<li><a href="/">How Does it Work</a></li>
                </ul>
            </nav>
        </div>
        
		
		<div class="container"> 
		  <div class="modal" id="modal1"> 
			<p>Sign in to create a new map or view your maps that are previously made.</p>
			<form action="secure/maplist.cfm" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_self">
			  <input type="email" value="" name="userIn" class="location" id="location" placeholder="Email Address" />
			  <input type="password" value="" name="passIn" class="password" id="password" placeholder="Password" />
			  <p class="left" style="margin-top: 50px;">Are you a new user? <a href="createUser.cfm">Create an account.</a></p>
			  <input type="submit" name="subscribe" class="btn btn-primary btn-large pull-right" value="Sign In" />
			</form>
		  </div>
		</div>

		<script src="scripts/vendor.js"></script>
        <script src="scripts/scripts.js"></script>

	</body>
</html>
