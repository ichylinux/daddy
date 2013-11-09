function toggle_feature_dir(feature_dir) {
  $(feature_dir).parent('div.feature_dir').nextUntil('div.feature_dir').toggle(250);
};

function toggle_step_file(step_file) {
  $(step_file).closest('li').next('.step_contents').toggle(250);
  event.stopPropagation();
};
