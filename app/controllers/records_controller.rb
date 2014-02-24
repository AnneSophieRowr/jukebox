class RecordsController < ApplicationController

  def index
  end
  
  def chart_data
    data = Record.send(params[:stat], params[:type])
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
    steps = values.length
    #return {scaleOverride: true, scaleSteps: steps, scaleStepWidth: scale, scaleStartValue: 1, animation: true, animationEasing: "easeOutQuart"}
    return {animation: true, animationEasing: "easeOutQuart"}
  end


end
