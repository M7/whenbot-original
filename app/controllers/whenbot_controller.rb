class WhenbotController < ApplicationController

  # /whenbot/:channel/:trigger/callback
  def callback
    
    response = Task.handle_callback(params[:channel], params[:trigger], params, request.headers, request.body.read)
    response = validate_response(response)
    
    if response[:head_only]
      head response[:status]
    else
      render response[:type] => response[:body], 
             :status => response[:status], 
             :layout => false
    end
  end

  private
  
  def validate_response(response)
    response ||= {}
    response[:head_only]  ||= response[:body] ? false : true
    response[:status]     ||= :ok
    response[:type]       ||= :json
    response[:headers]    ||= ''
    response[:body]       ||= 'Success'
    response
  end
  

end
