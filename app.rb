require_relative 'dto'

class App
  attr_accessor :attributes

  def initialize(**attributes)
    @attributes = attributes
  end

  def self.call(...)
    App.new(...).call
  end

  def call
    run
  end
  
  private

  def run
    # build_with_raw_dto
    # build_with_struct
    # build_with_open_struct
    # build_with_data
    [
      build_with_raw_dto, 
      build_with_struct, 
      build_with_open_struct, 
      build_with_data
    ]
  end

  # customize
  def build_with_raw_dto
    Dto.new(**attributes)
  end

  # speed
  # change values
  def build_with_struct
    # temp_class = Struct.new(:name)
    temp_class = Struct.new(*attributes.keys)
    # temp_class.new(*attributes)
    temp_class.new(**attributes)
  end

  # return nil
  # heavy
  # flexible
  # change values
  # create attributes
  def build_with_open_struct
    require 'ostruct'
    temp_object = OpenStruct.new
    attributes.keys.each do |key|
      # temp_object.name = 'batata'
      temp_object.send("#{key.to_s}=", attributes[key])
    end
    temp_object
  end

  # dto
  def build_with_data
    # temp_class = Data.define(:name, :age)
    temp_class = Data.define(*attributes.keys)

    # temp_class.new('batata', 30)
    # temp_class.new(*attributes.values)

    # temp_class.new(name: 'batata', age: 30)
    temp_class.new(**attributes)
  end
end

attributes = {
  name: 'batata',
  age: 30
}

# result_dto = App.call({name: 'batata'})
# result_dto = App.call(attributes)

# result_dto = App.call(name: 'batata')
# result_dto = App.call(**attributes)

# p result_dto

raw_dto, struct, open_struct, data = App.call(**attributes)

binding.irb
