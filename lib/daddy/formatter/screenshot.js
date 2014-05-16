$(document).ready(function() {
  var viewer = $('<div id="screenshot_viewer" style="display: none;"></div>');
  viewer.css({position: 'absolute'});
  viewer.appendTo(document.body);

  $('.screenshot').click(function() {
    var clone= $(this).clone().removeClass('screenshot');
    clone.click(function() {
      viewer.hide();
    });
    
    viewer.empty().append(clone);
    
    viewer.css('left', $(window).scrollLeft());
    viewer.css('top', $(window).scrollTop());
    viewer.show();
  });
});
