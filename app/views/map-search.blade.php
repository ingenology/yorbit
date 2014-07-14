@extends('layouts.master')

@section('title')Step 1 @endsection

@section('content')
	<div class="modal" id="modal1"> 
		<p>Enter the name of a city, or a zip code followed the date and type of map that you would like to use.</p>
		{{ Form::open(array('method' => 'POST', 'url' => 'step-2', 'role' => 'form')) }}
			{{ Form::label('location', 'Location', array('class' => 'control-label')) }}
			{{ Form::text('location', null, array('class' => 'location', 'placeholder' => 'Kansas City', 'id' => 'location', 'autocomplete' => 'off')) }}
			{{ Form::label('dateIn', 'Date', array('class' => 'control-label')) }}
			{{ Form::text('dateIn', null, array('class' => 'date', 'placeholder' => '2014-12-01', 'id' => 'dateIn', 'autocomplete' => 'off')) }}
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
			{{ Form::submit('Proceed', array('class' => 'btn btn-primary btn-large pull-right')) }}
            <div class="clear"></div>
		{{ Form::close() }}
	</div>
@stop