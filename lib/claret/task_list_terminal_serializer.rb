module Claret
  class TaskListTerminalSerializer
    # options:: if :all, all tasks are printed, otherwise just the incomplete ones
    def initialize(options=nil)
      @options = options
    end

    # Write the task list to the terminal
    #
    # task_list:: A Claret::TaskList to print
    def write(task_list)
      task_list.each do |task|
        printf("[%d] %s%s\n",task.id,task.name,additional_info(task)) if print? task
      end
    end

  private

    def additional_info(task)
      info = ""
      info = " (completed on #{task.completed_date})" if task.completed?
      info = " (started on #{task.started_date})" if task.started?
      info
    end

    def print?(task)
      return true if @options == :all
      return !task.completed?
    end
  end
end
