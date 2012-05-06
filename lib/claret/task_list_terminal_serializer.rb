module Claret
  class TaskListTerminalSerializer
    # options:: one of (defaults to :incomplete):
    #           :all - all tasks are printed
    #           :wip - started, but uncompleted tasks
    #           :incomplete - uncompleted tasks
    def initialize(options=:incomplete)
      @options = options 
    end

    # Write the task list to the terminal
    #
    # task_list:: A Claret::TaskList to print
    def write(task_list)
      task_list.each do |task|
        printf("[%d] %s%s\n",task.id,task.name,additional_info(task)) if PRINT[@options].call(task)
      end
    end

  private

    # Maps @options value to a lambda that determines if this task should be printed
    PRINT = {
      :all        => lambda { |task| true },
      :wip        => lambda { |task| task.wip? },
      :incomplete => lambda { |task| !task.completed? },
    }

    ADDITIONAL = [
      lambda { |task| "started on #{task.started_date}" if task.started? },
      lambda { |task| "completed on #{task.completed_date}" if task.completed? },
    ]

    def additional_info(task)
      info = ADDITIONAL.map { |func| func.call(task) }.compact.join(', ')
      if info != ''
        " (#{info})"
      else
        info
      end
    end
  end
end
