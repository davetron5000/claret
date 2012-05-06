require 'test_helper'

class TaskTest < TestCase
  include Claret
  include TaskHelper

  test_that "a task has a name and is incomplete when created" do
    Given {
      @task_name = any_sentence
      @task = Task.new(@task_name)
    }
    Then {
      assert_equal @task_name,@task.name
      refute @task.completed?
      assert_nil @task.completed_date
    }
  end

  test_that "a task's name is forced into UTF-8 encoding" do
    Given {
      @task_name = any_sentence.force_encoding("ASCII")
      @task = Task.new(@task_name)
    }
    Then {
      assert_equal "UTF-8",@task.name.encoding.name
    }
  end

  test_that "a task can be completed" do
    Given a_new_task
    When {
      @task.complete!
    }
    Then {
      assert @task.completed?
      refute_nil @task.completed_date
    }
  end

  test_that "a task can be started" do
    Given a_new_task
    When {
      @task.start!
    }
    Then {
      assert @task.started?
      refute_nil @task.started_date
    }
  end

  test_that "a task can be given an ID" do
    Given a_new_task
    And {
      @id = any_int
    }
    When {
      @task.id = @id
    }
    Then {
      assert_equal @id,@task.id
    }
  end

  test_that "we can rename a command" do
    Given a_new_task
    And {
      @new_name = @task.name + ' ' + any_string
    }
    When {
      @task.name = @new_name
    }
    Then {
      assert_equal @new_name,@task.name
    }
  end
end
