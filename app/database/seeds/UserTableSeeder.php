<?php

class UserTableSeeder extends Seeder {

	public function run()
	{
		// Uncomment the below to wipe the table clean before populating
		DB::table('users')->truncate();

		User::create(array(
			'email'		=> 'dev@ingenology.com'
		));

		// Uncomment the below to run the seeder
		DB::table('user')->insert($user);
	}

}