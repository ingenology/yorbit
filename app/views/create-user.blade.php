@extends('layouts.master')

@section('title')Create User @endsection

@section('content')

	<div class="modal" id="modal1"> 
		<p>Create a new user.</p>
		{{ Form::open(array('url' => 'create-user', 'role' => 'form')) }}
			{{ Form::label('email', 'Email', array('class' => 'control-label')) }}
			{{ Form::text('email', null, array('class' => 'location', 'placeholder' => 'test@example.com')) }}
			{{ Form::submit('Next Step', array('class' => 'btn btn-primary btn-large pull-right')) }}
		{{ Form::close() }}
	</div>
    
@endsection