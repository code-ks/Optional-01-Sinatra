class Recipe
  attr_reader :name, :description

  def initialize(name, description)
    @name = name
    @description = description
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
