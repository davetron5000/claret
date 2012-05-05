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
  File.open(File.join(ENV['HOME'],'.claret.yml'),'w') do |file|
    file.puts @locals[:tasks].to_yaml
  end
end

Then /^the output should show the three tasks$/ do
  @locals[:tasks].each do |task|
    step %{the output should contain "#{task}"}
  end
end
