module TaskHelper
  include Claret

  def a_new_task 
    lambda { @task = any_task }
  end

  def any_task
    Task.new(any_sentence)
  end

  def task
    raise "Did you mean @task?"
  end
end
