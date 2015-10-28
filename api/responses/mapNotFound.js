module.exports = function mapNotFound(id) {
  var res = this.res;
  var req = this.req;
  var sails = req._sails;

  sails.log.error('Map with ID: ' + id + ' was not found.');
  return res.notFound('Map with ID: ' + id + ' was not found.');
};
