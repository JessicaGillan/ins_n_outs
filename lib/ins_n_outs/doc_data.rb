class DocData
  attr_reader :method_data

  def initialize(data)
    @parser = CommentParser.new
    @method_data = @parser.parse_method_data(data)
    @spec_writer = SpecWriter.new
  end

  def get_specs
    @spec_writer.create_specs(method_data) 
  end
end
