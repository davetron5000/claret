module Claret
  # A thing to do
  class Task
    # The name of this task that explains what it is
    attr_accessor :name

    # The id of this task
    attr_accessor :id

    # Create a new, incomplete task with the given name
    #
    # name:: name of the task, i.e. what to do to complete task
    def initialize(name)
      @name = name.dup
      @name.force_encoding("UTF-8")
      @completed = false
    end

    # True if this task was completed
    def completed?
      @completed
    end

    # Completes this task
    def complete!
      @completed = true
    end
  end
end
