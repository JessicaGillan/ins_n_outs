class SpecWriter

  def create_specs(method_data)
    return nil unless method_data

    spec_text = ""

    spec_text << "describe #{method_data[0].container[0]} do\n\n" unless method_data[0].container.nil?

    method_data.each do |m_data|
      spec_text << parse_spec_for_m(m_data)
    end

    spec_text << "end\n\n" unless method_data[0].container.nil?

    spec_text
  end

  def parse_spec_for_m(m_data)
    spec = "\tdescribe \"##{m_data.name}\" do\n"

    if m_data.input_types.is_a? Array
      m_data.input_types.each do |type|
        spec <<  [
                    "\t\tit \"takes input type #{type}\" do",
                    "\t\t\texpect{ #{m_data.name}( #{type}.new ) }.not_to raise_error",
                    "\t\tend\n\n"
                  ].join("\n")
      end
    elsif m_data.input_types.is_a? Hash
    end

    if m_data.output_types.is_a? Array
      m_data.output_types.each do |type|
        input_str = m_data.input_types.join(".new, ")

        spec <<  [
                    "\t\tit \"outputs a #{type}\" do",
                    "\t\t\texpect(#{m_data.name}( #{input_str}.new )).to be_a(#{type})",
                    "\t\tend\n\n"
                  ].join("\n")
      end
    elsif m_data.output_types.is_a? Hash
    end

    spec << "\tend\n\n"
    spec
  end
end

# MethodData = Struct.new(:container, :name, :input_types, :output_types)
# [{name: arg_name, type: arg_type, default: default_test_val},
#   {name: arg_name, type: arg_type, default: default_test_val} ...]
