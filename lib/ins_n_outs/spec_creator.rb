class SpecCreator
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

  private

    def parse_spec_for_m(m_data)
      spec = "\tdescribe \"##{m_data.name}\" do\n"

      if m_data.input_types.is_a? Array

        if m_data.input_types.all? { |data| data.is_a? String }
          spec << parse_input_types(m_data.name, m_data.input_types)
        elsif m_data.input_types.all? { |data| data.is_a? Hash }
          spec << parse_input_hash(m_data.name, m_data.input_types)
        end

      end
      if m_data.output_types.is_a? Array

        if m_data.output_types.all? { |data| data.is_a? String }
          spec << parse_output_type(m_data.name, m_data.input_types, m_data.output_types)
        elsif m_data.output_types.all? { |data| data.is_a? Hash }
          spec << parse_output_hash(m_data.name, m_data.input_types, m_data.output_types)
        end

      end

      spec << "\tend\n\n"

      spec
    end

    def parse_input_types(method_name, in_types)
      input_str = in_types.join(", ")
      input_vals = in_types.join(".new, ") + ".new "

      input_expectation(method_name, input_vals, input_str)
    end

    def parse_output_type(method_name, in_types, out_type)
      type = out_type.first
      input_str = in_types.join(".new, ") + ".new "

      output_expectation(method_name, input_str, type)
    end

    def parse_input_hash(method_name, inputs)
      if inputs.none? { |input| input[:default].nil? }
        input_vals =  inputs.map do |input|
          input[:type] == "String" ? "\'#{input[:default]}\'" : input[:default]
        end.join(", ")

        input_expectation(method_name, input_vals)
      else
        required_vals =  inputs.select{ |input| input[:type] }
        input_vals =  required_vals.map{ |input| input[:type] }.join(".new, ") + ".new "
        input_str =  required_vals.map{ |input| input[:type] }.join(", ")

        input_expectation(method_name, input_vals, input_str)
      end
    end

    def parse_output_hash(method_name, inputs, outputs)
      if inputs.none? { |input| input[:default].nil? }
        input_vals =  inputs.map do |input|
          input[:type] == "String" ? "\'#{input[:default]}\'" : input[:default]
        end.join(", ")
      else
        required_vals =  inputs.select{ |input| input[:type] }
        input_vals =  required_vals.map{ |input| input[:type] }.join(".new, ") + ".new "
      end

      unless outputs[0][:type].nil?
        output_expectation(method_name, input_vals, outputs[0][:type])
      end
    end

    def input_expectation(method_name, input_vals, input_str = nil)
      input_str ||= input_vals

      [
        "\t\tit \"takes inputs #{input_str}\" do",
        "\t\t\texpect{ #{method_name}( #{input_vals} ) }.not_to raise_error",
        "\t\tend\n"
      ].join("\n")
    end

    def output_expectation(method_name, input_vals, output_type)
      [
        "\t\tit \"outputs a #{output_type}\" do",
        "\t\t\texpect(#{method_name}( #{input_vals} )).to be_a(#{output_type})",
        "\t\tend\n"
      ].join("\n")
    end
end
