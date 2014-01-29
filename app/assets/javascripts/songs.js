$(document).ready(function(){

  $("#song_playlist_ids, #song_album_ids").multiselect({
    includeSelectAllOption: true,
    selectAllText: 'Tout sélectionner',
    nonSelectedText: 'Aucune sélection',
    enableFiltering: true, 
    enableCaseInsensitiveFiltering: true,
    maxHeight: 300
  });

  $('#songs .pause').hide();

  $('#songs .play').on('click', function() {
    src = $('#jquery_jplayer_1').data().jPlayer.status.src;
    src = src.slice(src.indexOf('/uploads'), src.length);
    if (src != $(this).attr('src') || src == "") {
      $.ajax({
        url: $(this)[0].href,
        success: function(song){
          play(song);
        }
      });
    }
    else {
      $("#jquery_jplayer_1").jPlayer('play');
    }
    toggle($(this));
    return false;
  });

  $('#songs .pause').on('click', function() {
     $("#jquery_jplayer_1").jPlayer('pause');
     $(this).hide();
     $(this).prev().show();
  });
});

function toggle($play) {
  $('#songs .pause').hide();
  $('#songs .play').show();
  $play.hide();
  $play.next().show();
}

function play(song) {
  $("#jquery_jplayer_1").jPlayer('destroy');
  $("#jquery_jplayer_1").jPlayer( {
    ready: function() { 
      $(this).jPlayer("setMedia", { 
        mp3: song.mp3,
        artist: song.artist,
        title: song.title,
        poster: song.image
      }).jPlayer("play"); 
    },
    ended: function() { 
      $(this).jPlayer("play"); 
    },
    supplied: "mp3",
    swfPath: "/flash",
  });
  $('.jp-title').children().children().text(song.title);
}
