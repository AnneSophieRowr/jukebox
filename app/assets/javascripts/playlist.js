$(document).ready(function(){

  $("#playlist_kind_ids, #playlist_type_ids").multiselect({
    includeSelectAllOption: true,
    selectAllText: 'Tout sélectionner',
    nonSelectedText: 'Aucune sélection',
    enableFiltering: true, 
    enableCaseInsensitiveFiltering: true,
    maxHeight: 300
  }); 

  $('#playlists .pause').hide();

  $('#playlists .play').on('click', function() {
    $btn = $(this);
    $.ajax({
      url: $(this)[0].href,
      dataType: 'json',
      success: function(songs){
        var cssSelector = { jPlayer: "#jquery_jplayer_1", cssSelectorAncestor: "#jp_container_1" };
        var options = { swfPath: "/flash", supplied: "mp3", autoPlay: true };
        var myPlaylist = new jPlayerPlaylist(cssSelector, songs, options);
        myPlaylist.play(0);
        $btn.hide();
        $btn.next().show();
      }
    });
    return false;
  });

  $('#playlists .pause').on('click', function() {
    $(this).hide();
    $(this).prev().show();
    $("#jquery_jplayer_1").jPlayer('pause');
  });

});

