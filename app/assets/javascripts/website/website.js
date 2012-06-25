// js for website
$(document).ready(function() {
  $('#other-elements-icon').toggle(function() {
    $("#block-other-elements :input").attr("disabled", false)
    $('#block-other-elements').slideDown('slow');
  }, function() {
    $("#block-other-elements :input").attr("disabled", true)
    $('#block-other-elements').slideUp('slow');
  });  
});

// fancybox for location map
$(document).ready(function() {
  $('a#location-map').fancybox();
});

// старт поиска без дополнительных параметров - отключение дополнительных параметров
$(document).ready(function() {
  $("#block-other-elements :input").attr("disabled", true);
});
