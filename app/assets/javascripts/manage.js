$(document).ready(function(){

  template = '<div class="media">';
  template += '<a class="pull-left" href="#"><img class="media-object" src="{{img}}"></a>';
  template += '<div class="media-body"><h4 class="media-heading">{{title}}</h4>{{artist}}<br />{{album}}</div</div>';

  $(document).on('ajax:complete', '.delete_song', function(response, data) {
    $(this).parent().parent().hide();
  });

  $('.media-list')
    .on('mouseover', '.media', function() {
      $(this).children('.media-actions').css("visibility","visible");
    })
    .on('mouseout', '.media', function() {
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
    $.ajax({
      url: 'add_song',
      data: 'song_id=' + datum.song_id,
      success: function(data) {
        $('ul.media-list').append(data);
      }
    });
  });

});
