<!doctype html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title>
        	Yorbit | The world is your canvas.
        </title>
        <meta name="description" content="Yorbit is a way to personalize and share stunning photographs of Earth captured by NASA satellites.">

        <meta property="og:title" content="Yorbit | The world is your canvas." />
        <meta property="og:description" content="People create YORBIT earth art to commemorate a special moment, share a thought about a special place, and more. The possibilities are endless when the world is your canvas." />
        
        @include('partials.head-elements')

        <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,400italic' rel='stylesheet' type='text/css'>

    </head>
    <body class="home">
        <!--[if lt IE 9]>
            <div class="browser-check not-available">
                You are currently using a browser that <strong>does not support</strong> technology used by this website.<br />Please <a href="http://browsehappy.com/">upgrade your browser</a> to be able to view this site.
            </div>
        <![endif]-->
        <!--[if lt IE 10]>
            <div class="browser-check">
                You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.
            </div>
        <![endif]-->
        <div class="overlay overlay-door">
            <div class="close_button">
                <a href="#" class="close_navigation overlay-close" onclick="return false;">X</a>
            </div>
            @include('partials.navigation')
        </div>

        <header>
            <div class="container">
                <div class="logo">
                    <a href="/">
                        <img src="{{ asset('images/homepage/logo-white.png') }}" alt="Yorb.it" title="Yorb.it Logo" />
                    </a>
                </div>
                <div class="navigation-button" id="trigger-overlay">
                    <img src="{{ asset('images/homepage/menu_button-white.png') }}" /> 
                </div>
            </div>
        </header>
        <div class="banner">
            <div class="content">
                <div class="headline">
                    The world is your canvas.
                </div>
                <div class="subhead">
                    Searchable sharable satellite art.
                </div>
                <div class="button">
                    {{ HTML::link('step-1', 'Get Started', array('class' => 'btn btn-transparent')) }}
                </div>
            </div>
        </div>
        <section class="white">
            <div class="container">
                <div class="graphic">
                    <img src="{{ asset('images/homepage/ipad1.png') }}" />
                </div>
                <div class="content">
                    <div class="step-marker">
                        Step 1
                    </div>
                    <div class="heading">
                        NASA's earth art library awaits.
                    </div>
                    <p>Search by location, date or both, to find beautiful photographs that were captured by NASA satellites orbiting high above the earth. You can choose from Geo, Thermal and Night View maps.</p>
                    {{ HTML::link('step-1', 'Explore', array('class' => 'btn btn-primary btn-skinny')) }}
                </div>
            </div>
        </section>
        <section class="white">
            <div class="container">
                <div class="graphic">
                    <img src="{{ asset('images/homepage/ipad2.png') }}" />
                </div>
                <div class="content">
                    <div class="step-marker">
                        Step 2
                    </div>
                    <div class="heading">
                        Create a personal connection.
                    </div>
                    <p>Want to add a personal message that connects the photo with a special moment in someone's life?  Use our custom text tool to add a personalized message and choose your fonts, colors placement and more. </p>
                    {{ HTML::link('step-1', 'Explore', array('class' => 'btn btn-primary btn-skinny')) }}
                </div>
            </div>
        </section>
        <section class="white">
            <div class="container">
                <div class="graphic">
                    <img src="{{ asset('images/homepage/ipad3.png') }}" />
                </div>
                <div class="content">
                    <div class="step-marker">
                        Step 3
                    </div>
                    <div class="heading">
                        Share your view of the world.
                    </div>
                    <p>Art was meant to be admired, so we've made it easy to share your personalized satellite photography. Generate a custom link to email or post to social media and let the world (or someone special) know how you feel.</p>
                    {{ HTML::link('step-1', 'Explore', array('class' => 'btn btn-primary btn-skinny')) }}
                </div>
            </div>
        </section>
        <section class="centered">
            <div class="container">
                <div class="content">
                    <div class="step-marker">
                        Gallery
                    </div>
                    <div class="heading">
                        What bit will you share?
                    </div>
                    <p>People create YORBIT earth art to commemorate a special moment, share a thought about a special place, and more. What do you want to share?</p>
                </div>
            </div>
        </section>
        <div class="gallery">
            <div class="row">
                <div class="photo">
                    <img src="{{ asset('images/homepage/gallery1.jpg') }}" />
                </div>
                <div class="photo">
                    <img src="{{ asset('images/homepage/gallery2.jpg') }}" />
                </div>
                <div class="photo">
                    <img src="{{ asset('images/homepage/gallery3.jpg') }}" />
                </div>
            </div>
            <div class="row">
                <div class="photo">
                    <img src="{{ asset('images/homepage/gallery4.jpg') }}" />
                </div>
                <div class="photo">
                    <img src="{{ asset('images/homepage/gallery5.jpg') }}" />
                </div>
                <div class="photo">
                    <img src="{{ asset('images/homepage/gallery6.jpg') }}" />
                </div>
            </div>
        </div>
        <footer>
            <div class="container">
                <div class="left">
                    You’re just one click away from making your own masterpiece with NASA's help. 
                </div>
                <div class="right">
                    {{ HTML::link('step-1', 'Get Started', array('class' => 'btn btn-transparent')) }}
                </div>
            </div>
        </footer>
        
		@include('partials.footer-elements')
	</body>
</html>

