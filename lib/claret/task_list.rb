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
  end
end
