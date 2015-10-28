/**
 * Production environment settings
 *
 * This file can include shared settings for a production environment,
 * such as API keys or remote database passwords.  If you're using
 * a version control solution for your Sails app, this file will
 * be committed to your repository unless you add it to your .gitignore
 * file.  If your repository will be publicly viewable, don't add
 * any private information to this file!
 *
 */

module.exports = {

  /***************************************************************************
   * Set the default database connection for models in the production        *
   * environment (see config/connections.js and config/models.js )           *
   ***************************************************************************/

  environment: 'production',
  hookTimeout: 30000, // 30 seconds

  connections: {
    mongoProd: {
      adapter: 'sails-mongo',
      url: process.env.MONGOLAB_URI,
      schema: true
    }
  },
  session: {
    adapter: 'redis',
    host: 'REDIS_HOST',
    // port: 27017,
    user: 'REDIS_USER',
    pass: 'REDIS_PASSWORD',
    // ttl: <redis session TTL in seconds>,
    // db: 0,
    // prefix: 'sess:',
  },
  models: {
    connection: 'mongoProd',
    migrate: 'alter'
  },
  port: process.env.PORT || 5000,

  /***************************************************************************
   * Set the log level in production environment to "silent"                 *
   ***************************************************************************/

  log: {
    level: "silent"
  }

};
