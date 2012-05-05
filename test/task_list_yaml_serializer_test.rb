require 'test_helper'

class TaskListYamlSerializerTest < TestCase
  include Claret
  include TaskHelper

  test_that "serializes to YAML using a file" do
    Given {
      @task_list = TaskList.new
      @num_tasks = rand(10) + 2
      @num_tasks.times do 
        @task_list << any_task
      end
      @path = File.join('/tmp','some_path.yml')
      FileUtils.rm_rf @path
      @serializer = TaskListYamlSerializer.new(@path)
    }
    When {
      @serializer.write(@task_list)
    }
    Then {
      parsed = YAML::load(File.open(@path))
      assert parsed.kind_of?(TaskList),"Expected #{parsed.class.name} to be an Array"
      assert_equal @num_tasks,parsed.tasks.size
      assert parsed.tasks[0].kind_of?(Task),"Expected #{parsed.tasks[0].class.name} to be a Task"
    }
    When {
      @read_task_list = @serializer.read
    }
    Then {
      assert @read_task_list.kind_of?(TaskList),"Expected #{@read_task_list.class.name} to be a TaskList"
      assert_equal @num_tasks,@read_task_list.tasks.size
      assert @read_task_list.tasks[0].kind_of?(Task),"Expected #{@read_task_list.tasks[0].class.name} to be a Task"
    }
  end

  test_that "a non-existent file, when read, returns an empty TaskList" do
    Given {
      @path = File.join('/tmp','some_path.yml')
      FileUtils.rm_rf @path
    }
    When {
      @task_list = TaskListYamlSerializer.new(@path).read
    }
    Then {
      assert @task_list.tasks.empty?
    }
  end
end
