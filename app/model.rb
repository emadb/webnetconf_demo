class Todo
  include Mongoid::Document
  field :description
  field :due_date,  type: Date
  field :completed?, type: Boolean, default: false

  def self.create!(params)
    todo = Todo.new
    todo.description = params[:description]
    todo.due_date = Date.strptime(params[:due_date], '%d/%m/%Y')
    todo.save
    todo
  end
end
