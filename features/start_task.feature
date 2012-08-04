Feature: I can start tasks
  In order to keep track of what I'm doing
  I can start tasks to indicate they are in progress

  Scenario: Start a task
    Given there are three tasks in the task list
    When I successfully run `claret task start 1`
    Then the second task should show up as in progress

  Scenario: Start a task twice generates an error
    Given there are three tasks in the task list
    Given I successfully run `claret task start 1`
    When I run `claret task start 1`
    Then the exit status should not be 0
    And the stderr should contain "Task 1 is already started"

  Scenario: Start a completed task generates an error
    Given there are three tasks in the task list
    Given I successfully run `claret task done 1`
    When I run `claret task start 1`
    Then the exit status should not be 0
    And the stderr should contain "Task 1 is completed"

  @wip
  Scenario: Start a task that depends on incomplete tasks generates an error
    Given there are three tasks in the task list
    And task 1 depends on task 2
    When I run `claret task start 1`
    Then the exit status should not be 0
    And the stderr should contain "Task 1 depends on incomplete tasks, you must do those first"

  @wip
  Scenario: Start a task that depends on completed tasks is OK
    Given there are three tasks in the task list
    And task 1 depends on task 2
    And task 2 is completed
    When I run `claret task start 1`
    Then the exit status should be 0

  Scenario: Complete a non-existent task generates an error
    Given there are three tasks in the task list
    When I run `claret task start 4`
    Then the exit status should not be 0
    And the stderr should contain "No task with id 4"

  Scenario: Missing the index generates error and help
    Given there are three tasks in the task list
    When I run `claret task start`
    Then the exit status should not be 0
    And the stderr should contain "task_id is required"
