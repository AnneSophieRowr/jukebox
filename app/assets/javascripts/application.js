//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.ui.sortable
//= require jquery.ui.effect
//= require jquery.remotipart
//= require_tree .
//= require_tree ./libs

$(document).ready(function(){
  
  $("#jquery_jplayer_1").jPlayer();

  $('.play').on('click', function() {
    $("#jquery_jplayer_1").jPlayer('destroy');
    src = $(this).attr('src');
    $("#jquery_jplayer_1").jPlayer( {
      ready: function() { 
        $(this).jPlayer("setMedia", { 
          mp3: src
        }).jPlayer("play"); 
      },
      ended: function() { 
        $(this).jPlayer("play"); 
      },
      supplied: "mp3",
      swfPath: "/flash",
    });
  });

});

