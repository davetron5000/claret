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
  end
end
