require 'test_helper'

class TaskListTest < TestCase
  include Claret
  include TaskHelper

  test_that "a task list can store tasks" do
    Given {
      @task1 = any_task
      @task2 = any_task
      @task3 = any_task
      @task_list = TaskList.new
      @task_list << @task1
      @task_list << @task2
      @task_list << @task3
    }
    When {
      @all_tasks = @task_list.tasks
    }
    Then {
      assert @all_tasks.include?(@task1)
      assert @all_tasks.include?(@task2)
      assert @all_tasks.include?(@task3)
    }
  end

  test_that "a task list assigns an id when it's given a task" do
    Given a_new_task
    And {
      @task_list = TaskList.new
    }
    When {
      @task_list << @task
    }
    Then {
      refute_nil @task.id
    }
  end

  test_that "a task list doesn't assign an id when there already is one" do
    Given a_new_task
    And {
      @task_id = any_int :positive
      @task.id = @task_id
      @task_list = TaskList.new
    }
    When {
      @task_list << @task
    }
    Then {
      assert_equal @task_id,@task.id
      assert_equal (@task_id + 1),@task_list.next_id
    }
  end
end
