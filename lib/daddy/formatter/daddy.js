function toggle_feature_dir(feature_dir) {
  $(feature_dir).parent('div.feature_dir').nextUntil('div.feature_dir').toggle(250);
};
