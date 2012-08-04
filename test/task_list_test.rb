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

  test_that "when splitting a task, the dependencies are allocated correctly" do
    Given a_task_list
    And {
      @task_list.create_dependency(@task1.id,@task2.id)
      @task_list.create_dependency(@task2.id,@task3.id)
      @new_task1_name = 'foo'
      @new_task2_name = 'bar'
    }
    When {
      @task_list.split(@task2.id,[@new_task1_name,@new_task2_name])
    }
    Then {
      assert_depends_on @task1,task_named(@new_task1_name,@task_list)
      assert_depends_on @task1,task_named(@new_task2_name,@task_list)
      assert_depends_on task_named(@new_task1_name,@task_list),@task3
      assert_depends_on task_named(@new_task2_name,@task_list),@task3
    }
  end

private

  def assert_depends_on(task1,task2)
    assert task1.depends_on?(task2),"'#{task1}' doesn't depend on '#{task2}' (it, in fact, depends on #{task1.tasks_i_depend_on.join(',')})"
  end

  def task_named(task_name,task_list)
    task_list.each do |task|
      return task if task.name == task_name
    end
    raise "No such task named #{task_name}; test is borked"
  end

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
