class Client
  class << self
    def create(*args)
      add_instance new(*args)
    end

    def [](name)
      all[name]
    end

    def add_instance(client)
      @instances ||= {}
      name = client.name
      raise "Client exists already : #{name}" if @instances.key? name
      @instances[name] = client
    end

    def all
      @instances ||= {}
    end
  end

  attr_reader :name, :headcount

  def initialize(name, headcount)
    @name = name
    @headcount = headcount
  end
end
