@extends('layouts.master')

@section('title')Your Created Maps @endsection

@section('content')
<div class="modal map-list">
	<p>This is your earth gallery. View your creation, give it a name, or remove it from your collection.</p>
	<div class="map-entry" id="mapListContent"> 
		{{--
		@if ($maps->isEmpty())
			<p class="no-results">You have not created any maps yet. Click the button below to get started.</p>
			<a href="#" class="btn btn-primary btn-skinny">Create map</a> 
		@else
			<div class="detail">
				@foreach ($maps as $map)
					<div class="detail">
                        <input type="text" class="textfield" value="" />
                        <div class="buttons">
                            <a href="#" class="button">
                                View Map
                            </a>
                            <a href="#" class="button" onClick="return confirm('Are you sure you want to REMOVE this art?');">
                                Remove
                            </a>
                        </div>
                    </div>
				@endforeach
			</div>
		@endif
		--}}
	</div>
</div>
@stop