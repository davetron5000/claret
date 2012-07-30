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

    attr_reader :tasks_depending_on_me
    attr_reader :tasks_i_depend_on

    # Create a new, incomplete task with the given name
    #
    # name:: name of the task, i.e. what to do to complete task
    def initialize(name)
      @name = name.dup
      @name.force_encoding("UTF-8")
      @completed = false
      @tasks_i_depend_on = []
      @tasks_depending_on_me = []
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
      raise "Task #{self.id} is completed" if completed?
      @started_date = Time.now
      @started = true
    end

    # True if this task is started, but not completed?
    def wip?
      self.started? && !self.completed?
    end

    def depends_on(other_task)
      @tasks_i_depend_on << other_task
      other_task.tasks_depending_on_me << self
    end

    def no_longer_depends_on(other_task)
      @tasks_i_depend_on.delete(other_task)
      other_task.tasks_depending_on_me.delete(self)
    end
  end
end
