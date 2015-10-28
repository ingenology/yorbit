Yorbit SailsJS refactor
=======

This branch of the repository holds a [SailsJS](http://sailsjs.org/) rebuild of the award-winning Yorbit application built for the NASA Space Apps Challenge.

### Features

* Built on SailsJS (a NodeJS MVC framework)
* Bower support
* SASS/SCSS support
* Uses MongoDB for data storage and Redis for session storage
* Includes configuration for [Heroku](http://heroku.com) deployment

### Local Setup

**1.** Clone repository to local machine.

**2.** Within the `/config` directory create a new file named `local.js` with the following code:

```javascript
module.exports = {
  models: {
    migrate: 'alter'
  }
};
```

This tells SailsJS to use its native local DB plugin.

**3.** Ensure that the global Sails NodeJS package installed. Enter the following command to install the Sails command line tools:

```
npm install -g sails
```

**4.** Install all Node and Bower dependencies with:

```
npm install && bower install
```

5. Start the SailsJS server with:

```
sails lift
```

### Heroku deployment

**1.** Create a new application within the Heroku dashboard or with the [Heroku Toolbelt](https://toolbelt.heroku.com/)

**2.** As listed above, Yorbit utilizes MongoDB for data storage and Redis for session storage. To install these addons use the following commands:

```
$ heroku addons:create mongolab:sandbox
$ heroku addons:create redistogo:nano
```

**3.** Unlike MongoLab, the SailsJS Redis adapter does not support the url authentication, requiring you to parse the configuration url that Heroku will give you and then enter them into the necessary values with the `/config/env/production.js` file. For example, if the REDISTOGO_URL was:

```
redis://redistogo:9GkUN3U5aN838m46a4Eb0G38gbdw6T1A@bluegill.redistogo.com:9261/
```

Then the session object within `production.js` would be:

```javascript
session: {
  adapter: 'redis',
  host: 'bluegill.redistogo.com',
  port: 9261,
  user: 'redistogo',
  pass: '9GkUN3U5aN838m46a4Eb0G38gbdw6T1A'
}
```

**4.** Yorbit utilizes multiple Heroku buildpacks. They can be found within the `.buildpacks` file. In order for Heroku to read this file, a buildpack must be installed. To do so, use the following command:

```
heroku buildpacks:set https://github.com/ddollar/heroku-buildpack-multi.git
```

**5.** Commit all changes, and then push everything to Heroku to upload and launch the application. If necessary use the `heroku logs --tail` to trouble shoot.
