$(document).ready(function(){

  $("#playlist_kind_ids").multiselect({
    includeSelectAllOption: true,
    selectAllText: 'Tout sélectionner',
    nonSelectedText: 'Aucune sélection'
  }); 

  $('.import_btn').on('click', function() {
    $('#import_file').click();
  });

  $('#import_file').on('change', function() {
    $('form').submit();
    return false;
  });

  $('#playlists .pause').hide();

  template = '<div class="media">';
  template += '<a class="pull-left" href="#"><img class="media-object" src="{{img}}"></a>';
  template += '<div class="media-body"><h4 class="media-heading">{{title}}</h4>{{artist}}<br />{{album}}</div</div>';

  $(document).on('ajax:complete', '.delete_song', function(response, data) {
    $(this).parent().parent().hide();
  });

  $('li.media')
    .on('mouseover', function() {
      $(this).children('.media-actions').css("visibility","visible");
    })
    .on('mouseout', function() {
      $(this).children('.media-actions').css("visibility","hidden");
  });

  $('#sortable_songs').sortable({
    axis: 'y',
    dropOnEmpty: false,
    cursor: 'crosshair',
    items: 'li',
    opacity: 0.4,
    scroll: true,
    update: function(){
      $.ajax({
        url: $('#sortable_songs').attr('url'),
        type: 'post',
        data: $('#sortable_songs').sortable('serialize'),
        dataType: 'script',
        complete: function(request){
          $('#sortable_songs').effect('highlight');
        }  
      })  
    }   
  });

  $('.search_songs').typeahead([
    {
      limit: 5,
      valueKey: 'title',
      remote: '../../songs/search?q=%QUERY',
      template: template,
      engine: Hogan
    }
  ]);

  $('.search_songs').on('typeahead:selected', function (object, datum) {
    console.log(datum);
    $.ajax({
      url: 'add_song',
      data: 'song_id=' + datum.song_id,
      success: function(data) {
        $('ul.media-list').append(data);
      }
    });
  });

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

