@extends('layouts.master')

@section('title')Step 1 @endsection

@section('content')
	<div class="modal" id="modal1"> 
		<p>Enter the name of a city, or a zip code followed the date and type of map that you would like to use.</p>
		{{ Form::open(array('method' => 'POST', 'url' => 'step-2', 'role' => 'form', 'id' => 'search-form')) }}
            {{ Form::hidden('latitude', null, array('id' => 'search-latitude', 'autocomplete' => 'off')) }}
            {{ Form::hidden('longitude', null, array('id' => 'search-longitude', 'autocomplete' => 'off')) }}
			{{ Form::label('location', 'Location', array('class' => 'control-label')) }}
			{{ Form::text('location', null, array('class' => 'location', 'id' => 'location', 'autocomplete' => 'off')) }}
			{{ Form::label('dateIn', 'Date', array('class' => 'control-label')) }}
			{{ Form::text('dateIn', null, array('class' => 'date', 'id' => 'dateIn', 'autocomplete' => 'off')) }}
			<div class="button-group map-type">
                <p>Seach maps by the following</p>
                <div class="button first" data="3">
                    Thermal
                </div>
                <div class="button" data="2">
                    Night
                </div>
                <div class="button last active" data="1">
                    Geo
                </div>
            </div>
            {{ Form::select('mapType', array(
            	'1' => 'CorrectedReflectance_TrueColor',
            	'2' => 'City Lights',
            	'3' => 'MODIS_Aqua_SurfaceReflectance_Bands121'
        	), '1', array('class' => 'hidden', 'id' => 'mapType', 'autocomplete' => 'off')) }}
            <div class="btn btn-primary btn-large pull-right" id="map-search">Proceed</div>
            <div class="clear"></div>
		{{ Form::close() }}
	</div>
@stop

@section('scripts')
<div id="ajax-loader" style="display: none;">
    <div class="graphic"></div>
</div>
<div id="search-overlay">
    <div class="modal-container">
        <h2>Location search results:</h2>
        <p>We were able to find more than one result for the location that you searched. Please select below the location that you were want. If it does not appear, please search again.</p>
        <div class="results"></div>
        <div class="btn btn-small search-again">
            Search again
        </div>
    </div>
</div>
@stop