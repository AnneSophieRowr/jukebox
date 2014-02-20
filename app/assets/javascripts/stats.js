$(document).ready(function(){

  $('#stats_tab a').on('click', function(e) {
    e.preventDefault();
    $(this).tab('show');
  });

  if ($("#chart").length != 0) {
    load_chart('/records/chart_data?stat=total&type=Playlist');
  }

  $('.stats label').on('click', function() {
    console.log($(this).find('input').attr('url'));
    load_chart($(this).find('input').attr('url'));
  });

});

function load_chart(url) {
  ctx = $("#chart").get(0).getContext("2d");
  myNewChart = new Chart(ctx);
  $.getJSON( 
    url,
    function(chart_data) {
      new myNewChart.Bar(chart_data.data, chart_data.options);
    }
  );
}

