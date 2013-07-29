function toggle_feature_dir(feature_dir) {
  $(feature_dir).parent('div.feature_dir').nextUntil('div.feature_dir').toggle(250);
};

$(document).ready(function() {
  $('div.feature_dir span').hover(function() {
    $(this).css('cursor', 'pointer');
  });
});
