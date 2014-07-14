<!doctype html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title>
        	@yield('title') | Yorbit
        </title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="{{ asset('images/favicon.ico') }}">
        <link rel="apple-touch-icon" href="{{ asset('images/apple-touch-icon.png') }}" />
		<link rel="apple-touch-icon" sizes="57x57" href="{{ asset('images/apple-touch-icon-57x57.png') }}" />
		<link rel="apple-touch-icon" sizes="72x72" href="{{ asset('images/apple-touch-icon-72x72.png') }}" />
		<link rel="apple-touch-icon" sizes="76x76" href="{{ asset('images/apple-touch-icon-76x76.png') }}" />
		<link rel="apple-touch-icon" sizes="114x114" href="{{ asset('images/apple-touch-icon-114x114.png') }}" />
		<link rel="apple-touch-icon" sizes="120x120" href="{{ asset('images/apple-touch-icon-120x120.png') }}" />
		<link rel="apple-touch-icon" sizes="144x144" href="{{ asset('images/apple-touch-icon-144x144.png') }}" />
		<link rel="apple-touch-icon" sizes="152x152" href="{{ asset('images/apple-touch-icon-152x152.png') }}" />

        <link rel="stylesheet" href="{{ asset('styles/vendor.css') }}">
        <link rel="stylesheet" href="{{ asset('styles/styles.css') }}">

        <script src="{{ asset('scripts/vendor/modernizr.js') }}"></script>

        @if(Request::segment(1) === 'step-2' || Request::segment(1) === 'step-3' || Request::segment(1) === 'map')
            <link href='http://fonts.googleapis.com/css?family=Questrial|Source+Sans+Pro:300,400,600,700,400italic|Permanent+Marker|Playfair+Display:400,700,400italic|Lobster|Rokkitt:400,700|Yanone+Kaffeesatz:400,700|Indie+Flower|Special+Elite|Changa+One:400,400italic' rel='stylesheet' type='text/css'>
            <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCI_cLTI5OPo5B7Nrcm5AKRKcGsKkTLOCI"></script>
        @else
            <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,400italic' rel='stylesheet' type='text/css'>
        @endif

    </head>
    <body class="@yield('bodyClass')">
        <!--[if lt IE 10]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        @include('partials.header')

        @if($errors->has())
            <div class="notification warning">
                <div class="container">
                    <div class="title">Error</div>
                    @foreach ($errors->all() as $error)
                        <div class="message">
                            {{ $error }}
                        </div>
                    @endforeach
                </div>
            </div>
        @endif

        @if ($message = Session::get('success'))
            <!-- Success Messages -->
            <div class="notification success">
                <div class="container">
                    <div class="title">Success</div>
                    <div class="message">
                        {{ Session::get('success') }}
                    </div>
                </div>
            </div>
        @elseif ($message = Session::get('warning'))
            <!-- Error Messages -->
            <div class="notification warning">
                <div class="container">
                    <div class="title">Error</div>
                    <div class="message">
                        {{ $message }}
                    </div>
                </div>
            </div>
        @endif
        
		<div class="overlay overlay-door">
            <div class="close_button">
                <a href="#" class="close_navigation overlay-close" onclick="return false;">X</a>
            </div>
            @include('partials.navigation')
        </div>
		<div class="container">
			@yield('content')
		</div>
        @if(Request::segment(1) === 'step-2' || Request::segment(1) === 'step-3' || Request::segment(1) === 'map')
            <div id="ajax-loader">
                <div class="graphic"></div>
            </div>
        @endif

        @yield('scripts')
        
		<script src="{{ asset('scripts/vendor.js') }}"></script>
        <script src="{{ asset('scripts/scripts.js') }}"></script>

        <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
        <script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','UA-XXXXX-X');ga('send','pageview');
        </script>
	</body>
</html>

