class Task < ActiveRecord::Base
  has_many :triggers
  has_many :actions
  
  accepts_nested_attributes_for :triggers, :actions
  
  attr_accessible :name, :active, :trigger_attributes, :action_attributes
  
  #
  # Handles calling the appropriate Trigger's #callback method,
  # saves the match data to the table, and runs the Action(s) if
  # its conditions are met.
  #
  def self.handle_callback(channel, trigger, params, headers, body)
    triggers, ids_array = Trigger.triggers_for(channel, trigger)    
    returned_triggers, response = Whenbot.relay_callback(channel, trigger, triggers, params, headers, body)    
    Trigger.save_updated_triggers(returned_triggers, ids_array)
    response
  end
  
end
