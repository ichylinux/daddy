if (typeof String.prototype.endsWith !== 'function') {
  String.prototype.endsWith = function(suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
  };
};

if (typeof String.prototype.isBlank !== 'function') {
  String.prototype.isBlank = function() {
    return this.length == '';
  };
};

if (typeof String.prototype.isPresent !== 'function') {
  String.prototype.isPresent = function() {
    return this.length != '';
  };
};

if (typeof String.prototype.toInt !== 'function') {
  String.prototype.toInt = function() {
    return parseInt(this) || 0;
  };
};
