module Claret
  class SmartTaskParser
    def parse(task_names)
      if task_names.any? { |task_name| task_name =~ /,./ }
        task_names
      else
        task_names.join(' ').split(',')
      end
    end
  end
end
