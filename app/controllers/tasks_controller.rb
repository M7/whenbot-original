class TasksController < ApplicationController
  def index
  end

  def new
    # TODO: Consider switch this to a Presenter pattern, or something similar,
    # since there's other info we'll need here.
    @channels = Whenbot.trigger_channels
  end
end
