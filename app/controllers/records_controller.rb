class RecordsController < ApplicationController

  def index
  end
  
  def chart_data
    start_date = Date.parse(params[:start]).strftime('%Y-%m-%d 00:00:00')
    end_date = Date.parse(params[:end]).strftime('%Y-%m-%d 00:00:00')
    data = Record.send(params[:stat], params[:type], start_date, end_date)
    chart_data = { 
      data: {
        labels: data.first,
        datasets: [
          {   
            fillColor: 'rgba(151,187,205,0.5)',
            strokeColor: 'rgba(151,187,205,1)',
            pointColor: 'rgba(220,220,220,1)',
            pointStrokeColor: '#fff',
            data: data.last
          }   
        ],  
      },  
      options: chart_options(data.last)
    }   
    render json: chart_data 
  end

  def chart_options(values)
    scale = 1 
    steps = values.max 
    return {scaleOverride: true, scaleSteps: steps, scaleStepWidth: scale, scaleStartValue: 1, animation: true, animationEasing: "easeOutQuart"}
  end


end
