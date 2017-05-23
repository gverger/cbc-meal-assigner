module Collection
  def create(*args)
    add_instance new(*args)
  end

  def [](id)
    @instances ||= {}
    @instances[id]
  end

  def add_instance(object)
    @instances ||= {}
    id = object.id
    raise "#{self} already exists: #{id}" if @instances.key? id
    @instances[id] = object
  end

  def all
    @instances ||= {}
    @instances.values
  end

  def each
    all.each do |object|
      yield object
    end
  end
end
