@extends('layouts.master')

@section('title')View A Map @endsection

@section('description')
Art was meant to be admired, so we've made it easy to share your personalized satellite photography. Generate a custom link to email or post to social media and let the world (or someone special) know how you feel. @endsection

@section('bodyClass')share @endsection

@section('content')

<div class="application">
    <div class="map-holder">
        <div id="map"></div>
        <div id="map-content" style="display: block;">
            {{ $map_content }}
        </div>
        <div id="map-cover"></div>
    </div>
    <div class="tools">
        <div class="share">
            <p>Take a look at this recently created piece of work. Feel free to share this map or create your own by clicking below.</p>
            <a href="#" class="btn btn-skinny btn-block btn-primary" id="share-now">Share</a>
            {{ HTML::link('step-1', 'Create A Map', array('class' => 'btn btn-skinny btn-block btn-primary')) }}
        </div>
    </div>
</div>
@stop

@section('scripts')
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
            {{--
            <a href="http://pinterest.com/pin/create/button/?url=yourpageurl.html&amp;media=yourimgurl.html&amp;description=yourdescriptiontext" target="_blank" count-layout="none">
                <img src="/images/social_pintrest.png" alt="Share" />
            </a>
            
            <a class="addthis_button_pinterest_pinit" pi:pinit:url="http://www.addthis.com/features/pinterest" pi:pinit:media="http://www.addthis.com/cms-content/images/features/pinterest-lg.png">
                <img src="/images/social_pintrest.png" alt="Share" />
            </a>
            --}}
            <a class="addthis_button_tumblr">
                <img src="/images/social_tumblr.png" alt="Share" />
            </a>
            {{--
            <a class="addthis_button_google_plusone_badge">
                <img src="/images/social_google_plus.png" alt="Share" />
            </a>
            --}}
            <a class="addthis_button_email">
                <img src="/images/social_email.png" alt="Share" />
            </a>
        </div>
        <script type="text/javascript">
            var addthis_config = {
                data_track_addressbar: false
            };
            var addthis_share = {
                title: "Look at what was created on Yorbit.",
                description: "Click this link to view this canvas that was created with Yorbit."
            };
        </script>
        <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-534f30e029418f6a"></script>
        <!-- AddThis Button END -->
    </div>
</div>

<script type="text/javascript">
    var mapZoom = {{ $map_zoom }},
        mapCenter = '{{ $map_center }}',
        mapDate = '{{ $map_date }}';

    @if ($map_type === '1')
        var urlIn = 'http://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_TrueColor',
            googleLevel = 'GoogleMapsCompatible_Level9',
            zoomMax = 9,
            mapTypeName = 'MODIS_Terra_CorrectedReflectance_TrueColor';
    @elseif ($map_type === '2')
        var urlIn = 'http://map1.vis.earthdata.nasa.gov/wmts-webmerc/VIIRS_CityLights_2012',
            googleLevel = 'GoogleMapsCompatible_Level8',
            zoomMax = 8,
            mapTypeName = 'VIIRS_CityLights_2012';
    @else
        var urlIn = 'http://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Aqua_SurfaceReflectance_Bands121',
            googleLevel = 'GoogleMapsCompatible_Level9',
            zoomMax = 9,
            mapTypeName = 'MODIS_Aqua_SurfaceReflectance_Bands121';
    @endif
</script>
@stop