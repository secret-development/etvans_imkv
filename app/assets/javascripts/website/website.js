// js for website
$(document).ready(function() {
  $('#other-elements-icon').toggle(function() {
    $("#block-other-elements :input").removeAttr("disabled")
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


// for search form - js:

// change city - load districts
$(document).ready(function() {
  // functions :
  function disabled_district(){
    $("#search_district_id_eq")
      .attr("disabled", true)
      .html("<option>Нет района</option>");
  }
  
  function enable_district(){
    $("#search_district_id_eq")
      .attr("disabled", false)
  }
  
  // all districts :
  var districts = $("#search_district_id_eq").html();
  
  // first state
  var city_first = $("#search_city_id_eq :selected").text();
  var opt_fir = $(districts).filter("optgroup[label='"+city_first+"']")
    .prepend('<option value="">Все районы</option>')
    .html();
  $("#search_district_id_eq").html(opt_fir);
  if (!opt_fir) {
    disabled_district();
  };
  
  // change city
  $("#search_city_id_eq").change(function(event) {
    var city = $("#search_city_id_eq :selected").text();
    var options = $(districts).filter("optgroup[label='"+city+"']")
    .prepend('<option value="">Все районы</option>')
    .html();
    if (options) {
      enable_district();
      $("#search_district_id_eq").html(options);
    }
    else{
      disabled_district();
    };
  });
});

// // search digits:
// $(document).ready(function() {
//   $("#search_room_gte").autotab_filter('numeric');
//   $("#search_room_lte").autotab_filter('numeric');
//   $("#search_price_gte").autotab_filter('numeric');
//   $("#search_price_lte").autotab_filter('numeric');
//   // $("#search_area_gte").autotab_filter('numeric');
//   // $("#search_area_lte").autotab_filter('numeric');
// });

// search room
$(document).ready(function() {
    if($("form").is("#search-main-form")){
      var first_typesubject = $("#search_typesubject_id_eq option:selected").val();
      
      $.ajax({
        url: '/etvans/subjects/findtypesubject',
        type: 'POST',
        dataType: 'json',
        data: {id: first_typesubject},
        success: function(data, textStatus, xhr) {
          if (data['room'] == true) {
            $("#room-search-block :input").removeAttr('disabled');
            $("#room-search-block").show();
          }
          else if (data['room'] == false){
            $("#room-search-block :input").attr('disabled', true);
            $("#room-search-block").hide();
          };
        }
      });  
  }
  
  $("#search_typesubject_id_eq").change(function(event) {
    var typesubject_id = $(this).attr("value");
    $.ajax({
      url: '/etvans/subjects/findtypesubject',
      type: 'POST',
      dataType: 'json',
      data: {id: typesubject_id},
      success: function(data, textStatus, xhr) {
        if (data['room'] == true) {
          $("#room-search-block :input").removeAttr('disabled');
          $("#room-search-block").show();
        }
        else if (data['room'] == false){
          $("#room-search-block :input").attr('disabled', true);
          $("#room-search-block").hide();
        };
      }
    });
  });
  
});

// search floor
$(document).ready(function() {
    if($("form").is("#search-main-form")){
      var first_typesubject = $("#search_typesubject_id_eq option:selected").val();
      
      $.ajax({
        url: '/etvans/subjects/findtypesubject',
        type: 'POST',
        dataType: 'json',
        data: {id: first_typesubject},
        success: function(data, textStatus, xhr) {
          if (data['floor'] == true) {
            $("#floor-search-block :input").removeAttr('disabled');
            $("#floor-search-block").show();
          }
          else if (data['floor'] == false){
            $("#floor-search-block :input").attr('disabled', true);
            $("#floor-search-block").hide();
          };
        }
      });  
  }
  
  $("#search_typesubject_id_eq").change(function(event) {
    var typesubject_id = $(this).attr("value");
    $.ajax({
      url: '/etvans/subjects/findtypesubject',
      type: 'POST',
      dataType: 'json',
      data: {id: typesubject_id},
      success: function(data, textStatus, xhr) {
        if (data['floor'] == true) {
          $("#floor-search-block :input").removeAttr('disabled');
          $("#floor-search-block").show();
        }
        else if (data['room'] == false){
          $("#floor-search-block :input").attr('disabled', true);
          $("#floor-search-block").hide();
        };
      }
    });
  });
  
});

// search for residents(hide/show - dependent typesubject)
$(document).ready(function() {
    if($("form").is("#search-main-form")){
      var first_typesubject = $("#search_typesubject_id_eq option:selected").val();
      
      $.ajax({
        url: '/etvans/subjects/findtypesubject',
        type: 'POST',
        dataType: 'json',
        data: {id: first_typesubject},
        success: function(data, textStatus, xhr) {
          if (data['resident'] == true) {
            $("#resident-search-block :input").removeAttr('disabled');
            $("#resident-search-block").show();
          }
          else if (data['resident'] == false){
            $("#resident-search-block :input").attr('disabled', true);
            $("#resident-search-block").hide();
          };
        }
      });  
  }
  
  $("#search_typesubject_id_eq").change(function(event) {
    var typesubject_id = $(this).attr("value");
    $.ajax({
      url: '/etvans/subjects/findtypesubject',
      type: 'POST',
      dataType: 'json',
      data: {id: typesubject_id},
      success: function(data, textStatus, xhr) {
        if (data['resident'] == true) {
          $("#resident-search-block :input").removeAttr('disabled');
          $("#resident-search-block").show();
        }
        else if (data['resident'] == false){
          $("#resident-search-block :input").attr('disabled', true);
          $("#resident-search-block").hide();
        };
      }
    });
  });
});

// search - change city - load residents
$(document).ready(function() {
  // functions :
  function disabled_resident(){
    $("#search_resident_id_eq")
      .attr("disabled", true)
      .html("<option>Нет ЖК</option>");
  }
  
  function enable_resident(){
    $("#search_resident_id_eq")
      .attr("disabled", false)
  }
  
  // all residents :
  var residents = $("#search_resident_id_eq").html();
  
  // first state
  var city_first = $("#search_city_id_eq :selected").text();
  var opt_fir = $(residents).filter("optgroup[label='"+city_first+"']")
    .prepend('<option value="">Все ЖК</option>')
    .html();
  $("#search_resident_id_eq").html(opt_fir);
  if (!opt_fir) {
    disabled_resident();
  };
  
  // change city
  $("#search_city_id_eq").change(function(event) {
    var city = $("#search_city_id_eq :selected").text();
    var options = $(residents).filter("optgroup[label='"+city+"']")
    .prepend('<option value="">Все ЖК</option>')
    .html();
    if (options) {
      enable_resident();
      $("#search_resident_id_eq").html(options);
    }
    else{
      disabled_resident();
    };
  });
});

// photos (subject -> show)
$(document).ready(function() {
  $("#subject-show-photos-thumbs a").click(function(event) {
    var big_pic = $(this).attr('href');
    var thumb_pic = $(this).children().attr('src');
    $("#subject-show-photo-main a").attr('href', big_pic);
    $("#subject-show-photo-main a img").attr('src', thumb_pic)
    $("#subject-show-photos-thumbs").find("A.stActive").removeClass("stActive");
    $(this).addClass("stActive");
    return false;
  });

  // fancybox
  $("#subject-show-photo-main a").click(function(event) {
    var piclist = [];
    var curindex = 0;
    $("#subject-show-photos-thumbs a").each(function(idx) {
      piclist.push(this.href);
      if($(this).hasClass("stActive")) curindex=idx;
    });
    $.fancybox(piclist, {
        'padding'           : 0,
        'margin'            : 0,
        'centerOnScroll'    : true,
        'transitionIn'      : 'none',
        'transitionOut'     : 'none',
        'type'              : 'image',
        'changeFade'        : 0,
        'index'             : curindex
    });
    return false;
  });
});