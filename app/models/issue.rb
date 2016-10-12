class Issue < ActiveRecord::Base

  def self.to_label
    "#{chi_name}"
  end
end
