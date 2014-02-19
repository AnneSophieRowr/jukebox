$(document).ready(function(){

  template = '<div class="media">';
  template += '<a class="pull-left" href={{url}}><img class="media-object" src="{{img}}"></a>';
  template += '<div class="media-body"><h4 class="media-heading">{{label}}</h4>{{details}}</div></div>';

  $('.searchbar').typeahead({
    valueKey: 'label',
    remote: '/search?q=%QUERY',
    template: template,
    engine: Hogan
  });

  $('.searchbar').on('typeahead:selected', function (object, datum) {
    window.location = datum.url
  }); 

});
