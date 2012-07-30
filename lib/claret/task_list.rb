module Claret
  # A list of tasks, including ID assignment
  class TaskList

    # Look at what the next id is.  Generally exposed for testing
    attr_reader :next_id

    # The tasks contained in this list
    attr_reader :tasks

    def initialize
      @tasks = []
      @next_id = 1
    end

    # Add a task to the list
    def <<(new_task)
      if new_task.id.nil?
        new_task.id = @next_id
      end
      @tasks << new_task
      @next_id = (@tasks.map(&:id).max + 1)
    end

    # Iterate over each task
    def each(&block)
      @tasks.each(&block)
    end

    # Find a task by id, raising an exception if it's not there
    #
    # task_id:: the id to search for.  This will be coerced to an int, so you can safely pass in a string
    #
    # This will raise an exception if task_id is nil, or if the task could not be found
    def find(task_id)
      raise "task_id is required" if task_id.nil?
      task = @tasks.select { |task| task.id == task_id.to_i }.first
      raise "No task with id #{task_id}" if task.nil?
      task
    end

    # Split the given task with the given id into several new_tasks.
    # The existing task will be deleted.
    #
    # task_id:: id of the task to split
    # new_tasks:: array of String representing the new tasks
    def split(task_id,new_tasks)
      raise "must split a task into at least two tasks" if new_tasks.size < 2
      task_to_split = self.find(task_id)
      self.tasks.delete(task_to_split)
      new_tasks.each do |new_task|
        self << Claret::Task.new(new_task)
      end
    end

    # Create a dependency between two tasks.  The task identified
    # by +task_id+ will depend on the task identified by +depends_on_task_id+
    #
    # task_id:: id of the task that will depend on the other task
    # depends_on_task_id:: id of the task that +task_id+ depends on 
    def create_dependency(task_id,depends_on_task_id)
      task = self.find(task_id)
      depends_on_task = self.find(depends_on_task_id)
      task.depends_on(depends_on_task)
    end

    def break_dependency(task_id,depends_on_task_id)
      task = self.find(task_id)
      depends_on_task = self.find(depends_on_task_id)
      task.no_longer_depends_on(depends_on_task)
    end
  end
end
