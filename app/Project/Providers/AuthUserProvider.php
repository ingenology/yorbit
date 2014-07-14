<?php

namespace Project\Providers;

use Illuminate\Auth\UserProviderInterface;
use Illuminate\Auth\GenericUser;

class AuthUserProvider implements UserProviderInterface {
    
    /**
    * External webservice for authentication
    */
    private $webservice;

    /**
    * The user object.
    */
    private $user;

    /**
    * Constructor
    *
    * @return void
    */
    public function __construct(\Project\Webservice\Auth $webservice)
    {
        $this->webservice = $webservice;
        $this->user = null;
    }

    /**
    * Retrieves a user by id
    *
    * @param int $identifier
    * @return mixed null|array
    */
    public function retrieveByID($identifier)
    {
        $this->user = is_null($this->user) ? $this->webservice->find($identifier) : $this->user;
        return $this->user;
    }

    public function retrieveByToken($identifier, $token);
    public function updateRememberToken(\Illuminate\Auth\UserInterface $user, $token);

    /**
    * Tries to find a user based on the credentials passed.
    *
    * @param array $crendtials username|password
    * @return mixed bool|UserInterface
    */
    public function retrieveByCredentials(array $credentials)
    {
        if(!$user = $this->webservice->find($credentials['username'])) return false;

        return new GenericUser($user);
    }

    /**
    * Validates the credentials passed to the ones in webservice.
    *
    * @param UserInterface $user
    * @param array $credentials
    * @return bool
    */
    public function validateCredentials(\Illuminate\Auth\UserInterface $user, array $credentials)
    {
        return $this->webservice->validateCredentials($credentials['password'], $user->password);
    }

}