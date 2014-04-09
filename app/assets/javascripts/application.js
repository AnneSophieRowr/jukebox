//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.ui.sortable
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= require jquery.ui.effect
//= require jquery.remotipart
//= require_tree .
//= require_tree ./libs

$(document).ready(function(){

  $("#jquery_jplayer_1").jPlayer();

  $('.import_btn').on('click', function() {
    console.log('1');
    $('#import_file').click();
  });

  $('#import_file').on('change', function() {
    console.log('2');
    $('#import_form').submit();
    return false;
  });

  $('form').on('ajax:complete', function(evt, data) {
    console.log('3');
    $(".partial")[0].innerHTML = data.responseText;
  });

});

