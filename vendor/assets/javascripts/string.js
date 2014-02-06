if (typeof String.prototype.isBlank !== 'function') {
  String.prototype.isBlank = function(string) {
    return string == null || string.length == '';
  };
};

if (typeof String.prototype.isPresent !== 'function') {
  String.prototype.isPresent = function(string) {
    return string != null && string.length != '';
  };
};

if (typeof String.prototype.endsWith !== 'function') {
  String.prototype.endsWith = function(suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
  };
};
