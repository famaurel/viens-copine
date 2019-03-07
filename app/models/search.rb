class Search
  include ActiveModel::Validations

  attr_accessor :start_address, :end_address, :start_time, :transport

  def initialize(attrs={})
    @start_address = attrs[:start_address]
    @end_address = attrs[:end_address]
    @start_time = attrs[:start_time]
    @transport = attrs[:transport]
  end

  def self.test
    "Coco"
  end

end
