<?php

class MapCreationController extends \BaseController {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		return View::make('map-search');
	}

	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function searchMap()
	{
		// Validates all inputs.
		$rules = array(
			'location'       => 'required',
			'dateIn'      => 'required'
		);
		$validator = Validator::make(Input::all(), $rules);

		// Validates if date is valid
		$currentDate = date('Y-m-d');
		$currentDate = str_replace('-', '', $currentDate);
		$currentDate = intval($currentDate);
		$selectedDate = Input::get('dateIn');
		$selectedDate = str_replace('-', '', $selectedDate);
		$selectedDate = intval($selectedDate);

		if ($validator->fails()) {
			return Redirect::to('step-1')->withErrors($validator)->withInput();
		} else if ($selectedDate < 20120501) {
			return Redirect::to('step-1')->with('warning', 'Images for this date are not available.');
		} else if ($selectedDate >= $currentDate) {
			return Redirect::to('step-1')->with('warning', 'Please select a date that is not in the future.');
		} else {
			$data = Input::all();
			return View::make('layout-create', $data);
		}
	}

	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function storeMap()
	{	
		$map 					= new Map;
		$map->map_zoom			= Input::get('map_zoom');
		$map->map_center		= Input::get('map_center');
		$map->map_content		= Input::get('map_content');
		$map->map_location		= Input::get('map_location');
		$map->map_date			= Input::get('map_date');
		$map->map_type			= Input::get('map_type');
		$map->save();

		$lastID = $map->id;
		return Redirect::action('MapCreationController@viewMap', $lastID)->with('success', 'Your map has been successfully created.');
	}

	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function viewMap($id)
	{
		$data = Map::find($id);
        return View::make('view-map', $data);
	}


}
