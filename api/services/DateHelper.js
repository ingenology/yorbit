// Date Helper
module.exports = {
  getDate: function() {
    var d = new Date();
    var fullDate = String(d.getFullYear()) + String((d.getMonth() + 1)) + String(d.getDate());
    return Number(fullDate);
  }
}
