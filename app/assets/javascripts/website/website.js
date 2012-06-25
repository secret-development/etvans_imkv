// js for website
$(document).ready(function() {
  $('#other-elements-icon').toggle(function() {
    $('#block-other-elements').slideDown('slow');
  }, function() {
    $('#block-other-elements').slideUp('slow');
  });  
});

// fancybox for location map
$(document).ready(function() {
  $('a#location-map').fancybox();
});

