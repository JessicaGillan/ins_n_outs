MethodData = Struct.new(:container, :name, :input_types, :output_types)

class CommentParser
  REGEX = { token: /#\s*DELIMITER:\s*(\S+)/,
            ins: /ins:\s*(.+),|ins:\s*(.+)outs:|ins:\s*(.+)/,
            outs: /outs:\s*(.+),|outs:\s*(.+)ins:|outs:\s*(.+)/,
            container: /class\s+(\w+)|module\s+(\w+)/
          }

  def initialize
    @method_data_factory = MethodData
  end

  def parse_method_data(lines)
    @token = set_token(lines)
    @container = find_container(lines)

    populate_token_regex(token)

    specifications = find_methods(lines)
    populate_method_data(specifications)
  end

  private
    attr_reader :token, :tkn_regex, :container

    # Will find the FIRST delimter set w/: DELIMITER:
    # And set the delimiter token to any non-whitespace characters following it
    def set_token(lines)
      match = nil
      lines.find_index { |line| match = line.match(REGEX[:token]) }

      raise "No Delimiter Token Set" if match.nil?

      match.captures[0]
    end

    def find_container(lines)
      i = lines.find_index do |line|
            line.match(REGEX[:container])
          end

      i.nil? ? nil : find_match(lines[i], REGEX[:container])
    end

    def find_methods(lines)
      lines.select do |line|
        line.match(tkn_regex[:methods])
      end
    end

    # ** my_test, ins: String, outs: Bool
    def populate_method_data(specifications)
      specifications.map do |spec|
        method_data               = @method_data_factory.new
        method_data.container     = container
        method_data.name          = find_match(spec, tkn_regex[:name])[0]
        method_data.input_types   = separate_types( find_match(spec, REGEX[:ins]) )
        method_data.output_types  = separate_types( find_match(spec, REGEX[:outs]) )
        method_data
      end
    end

    def find_match(spec, match_exp)
      match = spec.match(match_exp)

      match.nil? ? nil : match.captures.select { |group| !group.nil? }
    end

    def separate_types(types)
      types.map do |group|
        group.split(" ")
      end.flatten
    end

    def populate_token_regex(token)
      @tkn_regex =  {
                        methods: /#\s*#{Regexp.quote(token)}\s*/,
                        name: /#\s*#{Regexp.quote(token)}\s*(\w+)/
                      }
    end

end
