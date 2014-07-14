@extends('layouts.master')

@section('title')Login @endsection

@section('content')
	<div class="modal" id="modal1"> 
		<p>Sign in to create a new map or view your maps that are previously made.</p>
		{{ Form::open(array('url' => 'login', 'role' => 'form')) }}
			{{ Form::label('email', 'Email', array('class' => 'control-label')) }}
			{{ Form::text('email', null, array('class' => 'location', 'placeholder' => 'test@example.com')) }}
			<p class="left" style="margin-top: 50px;">
				Are you a new user? <a href="{{ URL::to('create-user') }}">Create an account.</a>
			</p>
			{{ Form::submit('Sign In', array('class' => 'btn btn-primary btn-large pull-right')) }}
		{{ Form::close() }}
	</div>
@stop