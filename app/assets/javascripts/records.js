$(document).ready(function(){

  $('#stats_tab a').on('click', function(e) {
    e.preventDefault();
    $(this).tab('show');
  });

  $('.datetime').datetimepicker({
    pickTime: false, 
    language: 'fr',
    endDate: Date()
  });

  $('.datetime').on('change.dp', function(e) {
    loadChart($('label.active:visible input').attr('url') + getDates());
  });

  $('#stats_tab li a').on('click', function(e) {
    loadChart($('label.active:visible input').attr('url') + getDates());
  });

  if ($("#chart").length != 0) {
    t = new Date();
    start = '&start=' + t.getFullYear()  + '-01-01';
    end = '&end=' + t.getFullYear() + '-' + ("0" + (t.getMonth() + 1)).slice(-2)  + '-' + t.getDay();
    url = '/records/chart_data?stat=total&type=Playlist' + start + end;
    loadChart(url);
  }

  $('.stats label').on('click', function() {
    loadChart($(this).find('input').attr('url') + getDates());
  });

});

function loadChart(url) {
  ctx = $("#chart").get(0).getContext("2d");
  myNewChart = new Chart(ctx);
  $.getJSON( 
    url,
    function(chart_data) {
      new myNewChart.Bar(chart_data.data, chart_data.options);
    }
  );
}

function getDates() {
  start_date = $('#start_date').val();
  end_date = $('#end_date').val();
  return '&start=' + start_date + '&end=' + end_date;
}

