Feature: I can split tasks
  In order to get things done,
  I need to break up tasks into smaller units

  Scenario: Split up a task
    Given there are three tasks in the task list
    When I successfully run `claret task split 1 new subtask, other subtask`
    Then task 1 should be gone
    And there should be a task 'new subtask'
    And there should be a task 'other subtask'

  Scenario: Split up a task into three tasks
    Given there are three tasks in the task list
    When I successfully run `claret task split 1 new subtask, other subtask, yet another subtasks`
    Then task 1 should be gone
    And there should be a task 'new subtask'
    And there should be a task 'other subtask'
    And there should be a task 'yet another subtask'

  Scenario: Split up a task into two tasks with commas in them
    Given there are three tasks in the task list
    When I successfully run `claret task split 1 "this is, a task" "this is another, task"`
    Then task 1 should be gone
    And there should be a task 'this is, a task'
    And there should be a task 'this is another, task'

  Scenario: Splitting a task requires at least two tasks
    Given there are three tasks in the task list
    When I run `claret task split 1 new task`
    Then the exit status should not be 0
    And the stderr should contain "must split a task into at least two tasks"
