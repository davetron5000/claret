require 'test_helper'

class TaskListYamlSerializerTest < TestCase
  include Claret
  include TaskHelper

  test_that "serializes to YAML" do
    Given {
      @task_list = TaskList.new
      @num_tasks = rand(10) + 2
      @num_tasks.times do 
        @task_list << any_task
      end
      @io = StringIO.new
      @serializer = TaskListYamlSerializer.new
    }
    When {
      @serializer.write(@task_list,@io)
    }
    Then {
      parsed = YAML::load(@io.string)
      assert parsed.kind_of?(TaskList),"Expected #{parsed.class.name} to be an Array"
      assert_equal @num_tasks,parsed.tasks.size
      assert parsed.tasks[0].kind_of?(Task),"Expected #{parsed.tasks[0].class.name} to be a Task"
    }
    When {
      @io = StringIO.new(@io.string)
      @read_task_list = @serializer.read(@io)
    }
    Then {
      assert @read_task_list.kind_of?(TaskList),"Expected #{@read_task_list.class.name} to be a TaskList"
      assert_equal @num_tasks,@read_task_list.tasks.size
      assert @read_task_list.tasks[0].kind_of?(Task),"Expected #{@read_task_list.tasks[0].class.name} to be a Task"
    }
  end
end
