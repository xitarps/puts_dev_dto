class Dto
  # attr_accessor :name

  # def initialize(name: '')
  #   @name = name
  # end

  def initialize(**kwargs)
    # {name: 'batata', age: 30}
    kwargs.keys.each do |key|
      self.class.attr_accessor(key)
      instance_variable_set("@#{key.to_s}", kwargs[key])
    end
  end
end