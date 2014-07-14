<?php

class AuthController extends \BaseController {

	/**
	 * Display a listing of the resource.
	 * GET /auth
	 *
	 * @return Response
	 */
	public function showLogin()
	{
		//Check if we are already logged in
		if (Auth::check())
		{
			//Redirect to homepage
			return Redirect::to('view-map-list'); //->with('success', 'You are already logged in.');
		}

		//Show the login page
		return 	View::make('login');
	}

	/**
	 * Show the form for creating a new resource.
	 * GET /auth/create
	 *
	 * @return Response
	 */
	public function postLogin()
	{
		$userdata = array(
			'email' => Input::get('email')
		);

		$rules = array(
			'email' => 'Required'
		);

		$validator = Validator::make($userdata, $rules);

		//Check if the form validates with success
		if ($validator->passes())
		{

			// Try to log the user in.
			if (Auth::attempt($userdata))
			{
				//Redirect to the homepage
				return Redirect::to('view-map-list');//->with('success', 'You have logged in successfully.');
			}
			else
			{
				//Redirect to the login page
				return Redirect::to('login')->withErrors(array('email' => 'Email not found.'));
			}
		}

		return Redirect::to('login')->withErrors($validator);
	}

	public function getLogout()
	{
		//Log out
		Auth::logout();

		//Redirect to homepage
		return Redirect::to('login')->with('success', 'You are logged out');
	}

}