class RecordsController < ApplicationController

  def index
  end
  
  def chart_data
    data = Record.send(params[:stat], params[:type])
    labels = data.keys.collect {|id| Playlist.find(id).name.capitalize}
    chart_data = { 
            data: {
                    labels: labels,
                    datasets: [
                            {   
                            fillColor: 'rgba(151,187,205,0.5)',
                            strokeColor: 'rgba(151,187,205,1)',
                            pointColor: 'rgba(220,220,220,1)',
                            pointStrokeColor: '#fff',
                            data: data.values
                            }   
                    ],  
            },  
            options: chart_options(data.values)
    }   
    render json: chart_data 
  end

  def chart_options(values)
    scale = 1 
    max = values.max + 3 
    steps = max / scale
    return {scaleOverride: true, scaleSteps: steps, scaleStepWidth: scale, scaleStartValue: 0, animation: true, animationEasing: "easeOutQuart"}
  end


end
