require_relative "ins_n_outs/version"
require_relative "ins_n_outs/doc_loader"
require_relative "ins_n_outs/comment_parser"
require_relative "ins_n_outs/doc_data"
require_relative "ins_n_outs/spec_creator"

module InsNOuts
  # Your code goes here...
  def self.write_specs(spec_text, filepath)
    f = File.open(filepath, 'w+')
    f.write( spec_text  )
    f.close
  end

end


############################################################################
test_path = File.expand_path('../../test_1.rb', __FILE__)
test_spec_path = File.expand_path('../../spec/test_1_spec.rb', __FILE__)


doc = DocLoader.load(test_path, test_spec_path)
InsNOuts.write_specs( doc.get_specs, test_spec_path )


############################################################################
hash_spec_path = File.expand_path('../../spec/hash_test_spec.rb', __FILE__)

doc = DocData.new

test_data1 = {
  container: "PassHashParam",
  name: "will_it_work?",
  ins: [{type: "String", default: "hello?"},
        {type: "Array", default: "[1,2,3]"}],
  out: [{type: "Bool"}]
}

test_data2 = {
  container: "PassHashParam",
  name: "idk",
  ins: [{type: "Double", default: "21.0"}],
  out: [{type: "Double"}]
}

test_data3 = {
  container: "PassHashParam",
  name: "cross_ur_fingees",
  ins: [{type: "Integer", default: "12"},
        {type: "Hash", default: "{hi: bye}"},
        {type: "Array", default: "[1,2,3]"}],
  out: [{type: "Hash"}]
}

test_data4 = {
  container: "PassHashParam",
  name: "we_hopes",
  ins: [{type: "String", default: "yes buddy"},
        {type: "Char", default: "c"}],
  out: [{type: "Array"}]
}

doc.add_a_method(test_data1)
doc.add_a_method(test_data2)
doc.add_a_method(test_data3)
doc.add_a_method(test_data4)
InsNOuts.write_specs( doc.get_specs, hash_spec_path)


############################################################################
