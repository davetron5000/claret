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
      raise "Task #{self.id} depends on incomplete tasks" unless @tasks_i_depend_on.all? { |task| task.completed? }
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
      raise "Task #{self.id} depends on incomplete tasks, you must do those first" unless @tasks_i_depend_on.all? { |task| task.completed? }
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

    def depends_on?(other_task)
      @tasks_i_depend_on.include?(other_task)
    end

    def no_longer_depends_on(other_task)
      @tasks_i_depend_on.delete(other_task)
      other_task.tasks_depending_on_me.delete(self)
    end

    def to_s
      "#{id}:#{name}"
    end

    # Split this task into new tasks with the given names.
    def split(new_task_names)
      new_tasks = new_task_names.map { |name| 
        deep_copy.tap { |new_task|
          new_task.name = name
          new_task.id = nil
        }
      }
      @tasks_i_depend_on.dup.each do |task|
        self.no_longer_depends_on(task)
        new_tasks.each do |new_task|
          task.tasks_depending_on_me << new_task
        end
      end
      @tasks_depending_on_me.each do |task|
        task.tasks_i_depend_on.delete(self)
        new_tasks.each do |new_task|
          task.tasks_i_depend_on << new_task
        end
      end
      new_tasks
    end

  protected

    attr_writer :tasks_i_depend_on
    attr_accessor :tasks_depending_on_me

  private

    def deep_copy
      self.dup.tap { |copy|
        copy.tasks_i_depend_on = self.tasks_i_depend_on.dup
        copy.tasks_depending_on_me = self.tasks_depending_on_me.dup
      }
    end
  end
end
