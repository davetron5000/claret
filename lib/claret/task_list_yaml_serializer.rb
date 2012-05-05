require 'yaml'

module Claret
  class TaskListYamlSerializer
    def initialize(path)
      @path = path
    end

    # Write the task list to the given IO in YAML format
    #
    # task_list:: A Claret::TaskList to serialize
    def write(task_list)
      File.open(@path,'w') do |file|
        file.puts task_list.to_yaml
      end
    end

    # Read a TaskList from the given IO
    def read
      File.open(@path) do |file|
        YAML::load(file)
      end
    rescue Errno::ENOENT
      Claret::TaskList.new
    end
  end
end
