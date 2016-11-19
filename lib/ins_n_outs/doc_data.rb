class DocData
  attr_reader :method_data

  def initialize(data = nil)
    @parser = CommentParser.new
    @method_data = @parser.parse_method_data(data) unless data.nil?
    @spec_creator = SpecCreator.new
    @method_data_factory = MethodData
  end

  def get_specs
    @spec_creator.create_specs(method_data)
  end

  def add_a_method(params)
    @method_data ||= []

    @method_data << create_m_data(params)
  end

  def create_m_data(params)
    m_data = @method_data_factory.new
    m_data.container     = [params[:container]]
    m_data.name          = params[:name]
    m_data.input_types   = params[:ins]
    m_data.output_types  = params[:out]
    m_data
  end
end
