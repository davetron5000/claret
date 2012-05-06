module Claret
  # A thing to do
  class Task
    # The name of this task that explains what it is
    attr_accessor :name

    # The id of this task
    attr_accessor :id

    # Date on which this task was completed
    attr_accessor :completed_date

    # Date on which this task was started
    attr_accessor :started_date

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
      raise "Task #{self.id} is already complete" if completed?
      @completed_date = Time.now
      @completed = true
    end

    # True if this task has been started
    def started?
      @started
    end

    # Starts this task
    def start!
      raise "Task #{self.id} is already started" if started?
      @started_date = Time.now
      @started = true
    end

    # True if this task is started, but not completed?
    def wip?
      self.started? && !self.completed?
    end
  end
end
