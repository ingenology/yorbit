@extends('layouts.master')

@section('title')Step 2 @endsection

@section('bodyClass')create @endsection

@section('content')

<div class="application">
    <div class="map-holder">
        <div id="map"></div>
        <div id="map-content">
            <div class="background"></div>
        </div>
    </div>
    <div class="tools">
        {{ Form::open(array('url' => 'step-3', 'role' => 'form', 'id' => 'map-creation')) }}
            
            {{ Form::hidden('map_zoom', null, array('id' => 'imgZoom')) }}
            {{ Form::hidden('map_center', null, array('id' => 'imgCent')) }}
            {{ Form::hidden('map_content', null, array('id' => 'formMapContent')) }}
            {{ Form::hidden('map_location', $location, array('id' => 'formMapLocation')) }}
            {{ Form::hidden('map_date', $dateIn, array('id' => 'formDateIn')) }}
            {{ Form::hidden('map_type', $mapType, array('id' => 'formMapType')) }}

            <div class="item type">
                <div class="title">
                    Type
                    <div class="icon"></div>
                </div>
                <div class="content">
                    <div class="row1">
                        <div class="buttons">
                            <div class="button" data="regular">
                                Regular
                            </div>
                            <div class="button" data="bold">
                                Bold
                            </div>
                            <div class="button" data="italic">
                                Italic
                            </div>
                        </div>
                    </div>
                    <div class="row2">
                        <select class="font-select" id="font-select">
                            <option value="'Changa One', cursive">Changa One</option>
                            <option value="'Indie Flower', cursive">Indie Flower</option>
                            <option value="'Lobster', cursive">Lobster</option>
                            <option value="'Permanent Marker', cursive">Permanent Marker</option>
                            <option value="'Playfair Display', serif">Playfair Display</option>
                            <option value="'Questrial', sans-serif">Questrial</option>
                            <option value="'Rokkitt', serif">Rokkitt</option>
                            <option value="'Source Sans Pro', sans-serif" selected>Source Sans Pro</option>
                            <option value="'Special Elite', cursive">Special Elite</option>
                            <option value="'Yanone Kaffeesatz', sans-serif">Yanone Kaffeesatz</option>
                        </select>
                        <input class="color-select" id="text_color_picker" />
                    </div>
                    <div class="row3">
                        <div class="slider-group">
                            <div class="label left">A</div>
                            <div class="bar_slider"></div>
                            <input type="hidden" name="textSize" id="textsize" />
                            <div class="label right">A</div>
                        </div>
                    </div>
                    <div class="row4">
                        <textarea name="messageIn" id="messageIn" placeholder="Please type here to edit your text."></textarea>
                    </div>
                    <div class="row5">
                        <div class="button left" id="add_text">
                            Add
                        </div>
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
                        <div class="square" id="add_square"></div>
                        <div class="circle" id="add_circle"></div>
                        <div class="buttons">
                            <div class="button delete" id="delete_shape">
                                Delete
                            </div>
                            <input class="button color-picker" id="shape_color_picker" />
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
                        <div class="slider-group scale">
                            <div class="label left"></div>
                            <div class="bar_sliderS"></div>
                            <div class="label right"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="item patterns">
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
                    <div class="row2">
                        <div class="slider-group opacity">
                            <div class="label left"></div>
                            <div class="bar_slider"></div>
                            <div class="label right"></div>
                        </div>
                    </div>
                    <div class="row3">
                        <div class="button delete" id="delete-pattern">
                            Delete
                        </div>
                    </div>
                </div>
            </div>
            <div class="btn btn-small pull-right disable disabled" id="disable-canvas">
                Show Canvas
            </div>
            <div class="btn btn-primary btn-skinny pull-right save" id="save-map">
                Save &amp; Publish
            </div>
        {{ Form::close() }}
    </div>
</div>
@stop

@section('scripts')
<script type="text/javascript">
    var mapLatitude = {{ Input::get('latitude') }},
        mapLongitude = {{ Input::get('longitude') }},
        //mapLocation = '{{ Input::get('location') }}',
        dateIn = '{{ Input::get('dateIn') }}';

    @if (Input::get('mapType') === '1')
        var urlIn = 'http://map1.vis.earthdata.nasa.gov/wmts-webmerc/MODIS_Terra_CorrectedReflectance_TrueColor',
            googleLevel = 'GoogleMapsCompatible_Level9',
            zoomMax = 9,
            mapTypeName = 'MODIS_Terra_CorrectedReflectance_TrueColor';
    @elseif (Input::get('mapType') === '2')
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