<!doctype html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title>
        	@yield('title') | Yorbit
        </title>
        <meta name="description" content="@yield('description')">
        
        <meta property="og:title" content="@yield('title') | Yorbit" />
        <meta property="og:description" content="@yield('description')" />
        
        @include('partials.head-elements')

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
        
		<div class="overlay overlay-door yorbit-application">
            <div class="close_button">
                <a href="#" class="close_navigation overlay-close" onclick="return false;">X</a>
            </div>
            @include('partials.navigation')
        </div>
		<div class="container yorbit-application">
			@yield('content')
		</div>
        @if(Request::segment(1) === 'step-2' || Request::segment(1) === 'step-3' || Request::segment(1) === 'map')
            <div id="ajax-loader">
                <div class="graphic"></div>
            </div>
        @endif

        <div class="disclaimer">
             <div class="container">
                <div class="logo">
                    <a href="/">
                        <img src="{{ asset('images/logo.png') }}" alt="Yorb.it" title="Yorb.it Logo" />
                    </a>
                </div>
                <h2>Your current screen size is not large enough to support this application. Make your screen larger or view this on a different device.</h2>
                {{ HTML::link('/', 'Go Back', array('class' => 'btn btn-transparent btn-skinny')) }}
            </div>
        </div>

        @yield('scripts')
        
		@include('partials.footer-elements')
	</body>
</html>

