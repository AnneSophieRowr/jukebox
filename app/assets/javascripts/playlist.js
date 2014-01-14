$(document).ready(function(){

  template = '<div class="media">';
  template += '<a class="pull-left" href="#"><img class="media-object" src="{{img}}"></a>';
  template += '<div class="media-body"><h4 class="media-heading">{{title}}</h4>{{artist}}<br />{{album}}</div</div>';

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
      remote: '../../songs/search?q=%QUERY&playlist=' + $('#playlist').val(),
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
        console.log('ola que tal');
      }
    });
  });

  $('#playlists .play').on('click', function() {
    $.ajax({
      url: $(this)[0].href,
      dataType: 'json',
      success: function(songs){
        var cssSelector = { jPlayer: "#jquery_jplayer_1", cssSelectorAncestor: "#jp_container_1" };
        var options = { swfPath: "/flash", supplied: "mp3", autoPlay: true };
        var myPlaylist = new jPlayerPlaylist(cssSelector, songs, options);
        myPlaylist.play(0);
      }
    });
    return false;
  });

});

