When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

Given /^there is no task list$/ do
  FileUtils.rm_rf File.join(ENV['HOME'],'.claret.yml')
end

Then /^there should be one task, "([^"]*)"$/ do |task_name|
  step %{I run `claret ls`}
  step %{the output should contain "#{task_name}"}
end

Then /^the existing three tasks, plus the new one, "([^"]*)" should be in the output$/ do |task_name|
  step %{I run `claret ls`}
  step %{the output should contain "#{task_name}"}
  step %{the output should show the three tasks}
end

Given /^there are three tasks in the task list$/ do
  @locals[:tasks] = ['Rake Leaves','Take out Garbage','Do Dishes']
  task_list = Claret::TaskList.new
  @locals[:tasks].each_with_index do |name,index|
    task_list << Claret::Task.new(name).tap { |_| _.id = index }
  end
  Claret::TaskListYamlSerializer.new.write(task_list,File.open(File.join(ENV['HOME'],'.claret.yml'),'w'))
end

Then /^the output should show the three tasks$/ do
  @locals[:tasks].each_with_index do |task,index|
    step %{the output should contain "[#{index}] #{task}"}
  end
end

Then /^the second task should not show up by default$/ do
  step %{I successfully run `claret ls`}
  @locals[:tasks].each_with_index do |task,index|
    if index == 1
      step %{the output should not contain "#{task}"}
    else
      step %{the output should contain "#{task}"}
    end
  end
end

Then /^the help should be printed for "([^"]*)"$/ do |arg1|
  step %{the output should contain "task_id"}
end
