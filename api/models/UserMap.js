/**
* UserMap.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  schema: true,

  attributes: {

    map_content: {
      type: 'string'
    },
    map_location: {
      type: 'string',
      required: true
    },
    map_date: {
      type: 'string',
      required: true
    },
    map_type: {
      type: 'string',
      required: true
    },
    map_zoom: {
      type: 'string',
      required: true
    },
    map_center: {
      type: 'string',
      required: true
    }
  }
};
