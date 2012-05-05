Feature: I can add tasks
  In order to keep track of things to do
  I need to be able to add tasks

  Scenario: Add the first task
    Given there is no task list
    When I successfully run `claret add some task`
    Then there should be one task, "some task"

  Scenario: Add a new task to an existing list
    Given there are three tasks in the task list
    When I successfully run `claret add some task`
    Then the existing three tasks, plus the new one, "some task" should be in the output
