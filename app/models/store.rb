class Store < ActiveRecord::Base
  belongs_to :client
  
  validates :client_id, :name, :chi_name, :code, :presence => true
  
  def store_name
    "#{client.name} - #{name} - #{address}"
  end
  
  def chi_store_name
    "#{client.chi_name} - #{chi_name} - #{chi_address}"
  end
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Store.create(row.to_hash)
    end
  end
end
