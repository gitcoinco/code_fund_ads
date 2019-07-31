# Mix in for models that act as split test experiments and alternatives
module SplitTestable
  extend ActiveSupport::Concern

  NAME_DELIMITER = "-".freeze

  module ClassMethods
    def find_by_split_test_name(split_test_name)
      find_by id: split_test_name.split(NAME_DELIMITER).last
    end
  end

  def split_test_name
    [self.class.name, id].join(NAME_DELIMITER)
  end

  def split_experiment
    @split_experiment ||= Split::ExperimentCatalog.find(split_test_name)
  end

  def split_alternative(split_testable)
    split_experiment&.alternatives&.find { |a| a.name == split_testable.split_test_name }
  end

  # Abstract method to be overridden by models that act as split expermients
  def split_alternative_names
    []
  end
end
