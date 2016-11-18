require_relative "ins_n_outs/version"
require_relative "ins_n_outs/doc_loader"
require_relative "ins_n_outs/comment_parser"
require_relative "ins_n_outs/doc_data"
require_relative "ins_n_outs/spec_writer"

module InsNOuts
  # Your code goes here...
end

test_path = File.expand_path('../../test_1.rb', __FILE__)
doc = DocLoader.load(test_path)

p doc.method_data

test_spec_path = File.expand_path('../../spec/test_1_spec.rb', __FILE__)

f = File.open(test_spec_path, 'w+')
f.write( doc.get_specs  )
f.close



# args: /(.?)[\(|\s](.?)\)/

# class name, inputs = { argument name => type }, output_types
# takes a list of input values and run the test with expected output?
