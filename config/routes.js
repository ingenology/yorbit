/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes map URLs to views and controllers.
 *
 * If Sails receives a URL that doesn't match any of the routes below,
 * it will check for matching files (images, scripts, stylesheets, etc.)
 * in your assets directory.  e.g. `http://localhost:1337/images/foo.jpg`
 * might match an image file: `/assets/images/foo.jpg`
 *
 * Finally, if those don't match either, the default 404 handler is triggered.
 * See `api/responses/notFound.js` to adjust your app's 404 logic.
 *
 * Note: Sails doesn't ACTUALLY serve stuff from `assets`-- the default Gruntfile in Sails copies
 * flat files from `assets` to `.tmp/public`.  This allows you to do things like compile LESS or
 * CoffeeScript for the front-end.
 *
 * For more information on configuring custom routes, check out:
 * http://sailsjs.org/#!/documentation/concepts/Routes/RouteTargetSyntax.html
 */

module.exports.routes = {

  /***************************************************************************
  *                                                                          *
  * Make the view located at `views/homepage.ejs` (or `views/homepage.jade`, *
  * etc. depending on your default view engine) your home page.              *
  *                                                                          *
  * (Alternatively, remove this and add an `index.html` file in your         *
  * `assets` directory)                                                      *
  *                                                                          *
  ***************************************************************************/

  'GET /': {
    view: 'homepage',
    locals: {
      layout: null
    }
  },

  /***************************************************************************
  *                                                                          *
  * Custom routes here...                                                    *
  *                                                                          *
  * If a request to a URL doesn't match any of the custom routes above, it   *
  * is matched against Sails route blueprints. See `config/blueprints.js`    *
  * for configuration options and examples.                                  *
  *                                                                          *
  ***************************************************************************/

  'GET /step-1': {
    view: 'map-search',
    locals: {
      layout: 'application-layout',
      bodyClass: '',
      pageMeta: {
        title: 'Step 1',
        description: 'Enter the name of the location, the map type, and the date that you would like to select for your map.'
      }
    }
  },
  'POST /step-2': 'UserMapController.searchMap',
  'GET /step-2': {
    controller: 'UserMapController',
    action: 'showCreateLayout',
    locals: {
      layout: 'application-layout',
      bodyClass: 'create',
      pageMeta: {
        title: 'Step 2',
        description: 'Add shapes, patterns, and text to your map to make it your own creation!'
      }
    }
  },
  'POST /step-3': 'UserMapController.storeMap',
  'GET /map/:mapId': {
    controller: 'UserMapController',
    action: 'viewMap',
    locals: {
      layout: 'application-layout',
      bodyClass: 'share',
      pageMeta: {
        title: 'View A Map',
        description: 'Art was meant to be admired, so we\'ve made it easy to share your personalized satellite photography. Generate a custom link to email or post to social media and let the world (or someone special) know how you feel.'
      }
    }
  }
};
