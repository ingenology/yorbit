<?php

class MapsTableSeeder extends Seeder {

	public function run()
	{
		// Uncomment the below to wipe the table clean before populating
		DB::table('maps')->truncate();

		$map = array(
			'map_content'		=> '<div class="text-item ui-draggable" id="text1" style="color: rgb(83, 190, 115); font-weight: normal; font-style: normal; font-size: 34px; font-family: \'Special Elite\', cursive; left: 313px; top: 378px;"><span>Welcome to KC,</span></div><div class="text-item" id="text2" style="color: rgb(83, 190, 115); font-weight: normal; font-style: normal; font-family: \'Special Elite\', cursive; font-size: 56px; left: 64px; top: 424px;"><span>... home of Yorbit.</span></div><div class="pattern stripes" style="opacity: 0.17;"></div></div>',
			'map_location'		=> 'Kansas City',
			'map_date'			=> '2014-04-12',
			'map_type'			=> '1',
			'map_zoom'			=> '8',
			'map_center'		=> '(39.114053, -94.6274636)'
		);

		// Uncomment the below to run the seeder
		DB::table('maps')->insert($map);
	}

}