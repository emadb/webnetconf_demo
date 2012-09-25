class Todo
  include Mongoid::Document
  field :description
  field :due_date,  type: Date
  field :completed?, type: Boolean, default: false
end
