require 'test_helper'

class TaskListTest < TestCase
  include Claret
  include TaskHelper

  test_that "a task list can store tasks" do
    Given a_task_list
    When {
      @all_tasks = @task_list.tasks
    }
    Then {
      assert @all_tasks.include?(@task1)
      assert @all_tasks.include?(@task2)
      assert @all_tasks.include?(@task3)
    }
  end

  test_that "a task list has an each method that works like it ought" do
    Given a_task_list
    And {
      @tasks_found = []
    }
    When {
      @task_list.each do |task|
        @tasks_found << task
      end
    }
    Then {
      assert_equal @tasks_found,@task_list.tasks
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

  test_that "a task list can find a task by id" do
    Given a_task_list
    When {
      @task = @task_list.find(@task1.id)
    }
    Then {
      assert_equal @task,@task1
    }
  end

  test_that "a task list can find a task by id even if the id is a string" do
    Given a_task_list
    When {
      @task = @task_list.find(@task1.id.to_s)
    }
    Then {
      assert_equal @task,@task1
    }
  end

  test_that "when finding a task in a task list, it raises if the id isn't in the task list" do
    Given a_task_list
    When {
      @code = lambda { @task = @task_list.find(@task3.id + 1) }
    }
    Then {
      assert_raises(RuntimeError,&@code)
    }
  end

  test_that "when given a nil, TaskList#find raises" do
    Given a_task_list
    When {
      @code = lambda { @task = @task_list.find(nil) }
    }
    Then {
      exception = assert_raises(RuntimeError,&@code)
      assert_equal "task_id is required",exception.message
    }
  end

private

  def a_task_list
    lambda {
      @task1 = any_task
      @task2 = any_task
      @task3 = any_task
      @task_list = TaskList.new
      @task_list << @task1
      @task_list << @task2
      @task_list << @task3
    }
  end

end
