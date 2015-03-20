if (typeof daddy === "undefined") {
  var daddy = {};
}
daddy.screenshot = {};

daddy.screenshot.get_or_create_viewer = function() {
  if (!this.viewer) {
    this.viewer = $('<div id="screenshot_viewer" style="display: none;"></div>');
    this.viewer.css({position: 'absolute'}).appendTo('body');
    this.viewer.show_image = function(image) {
      var clone= $(image).clone().removeClass('screenshot');
    
      this.empty().append(clone);
      this.css('left', $(window).scrollLeft());
      this.css('top', $(window).scrollTop());
      this.show();
    };
    this.viewer.close = function() {
      this.hide();
    };
  }
  
  return this.viewer;
};

var viewer = null;

$(document).ready(function() {
  viewer = daddy.screenshot.get_or_create_viewer();

  $('body').click(function(e) {
    viewer.close();
    if ($(e.target).hasClass('screenshot')) {
      viewer.show_image(e.target);
    }
  });

});
