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
  Claret::TaskListYamlSerializer.new(File.join(ENV['HOME'],'.claret.yml')).write(task_list)
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

Given /^one of them is completed$/ do
  step %{I successfully run `claret task done 1`}
end

Given /^another one of them has been completed$/ do
  step %{I successfully run `claret task done 2`}
end

Then /^the completed task should be highlighted with the completion date$/ do
  step %{the output should match /#{@locals[:tasks][1]} \\\(completed on .*\\\)/}
end

Then /^the second task should show up as in progress$/ do
  step %{I successfully run `claret ls`}
  step %{the output should match /#{@locals[:tasks][1]} \\\(started on .*\\\)/}
end

Given /^one of them has been started$/ do
  @locals[:started_task_id] = 1
  step %{I successfully run `claret task start 1`}
end

Then /^the output should show the started task only$/ do
  @locals[:tasks].each_with_index do |task,index|
    if index == @locals[:started_task_id]
      step %{the output should match /#{task} \\\(started on .*\\\)/}
    else
      step %{the output should not contain "#{task}"}
    end
  end
end


Given /^that same one has been completed$/ do
  step %{I successfully run `claret task done #{@locals[:started_task_id]}`}
end

Then /^the output should show the started\/completed task's start and completed dates$/ do
  step %{the output should match /#{@locals[:tasks][@locals[:started_task_id]]} \\\(started on .*, completed on .*\\\)/}
end
