require 'yaml'

module Claret
  class TaskListYamlSerializer
    # Write the task list to the given IO in YAML format
    #
    # task_list:: A Claret::TaskList to serialize
    # io:: An IO where the task list YAML should be written
    def write(task_list,io)
      io.puts task_list.to_yaml
      io.close
    end

    def read(io)
      YAML::load(io).tap { io.close }
    end
  end
end
