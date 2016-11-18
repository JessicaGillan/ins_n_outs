require 'rdoc/rdoc'
require 'pry'


##
# This class represents an arbitrary shape by a series of points.

class Shape

  ##
  # Creates a new shape described by a +polyline+.
  #
  # If the +polyline+ does not end at the same point it started at the
  # first pointed is copied and placed at the end of the line.
  #
  # An ArgumentError is raised if the line crosses itself, but shapes may
  # be concave.

  def initialize polyline
    # ...
  end

end

options = RDoc::Options.new
# see RDoc::Options

rdoc = RDoc::RDoc.new
binding.pry
puts "past binding"
# rdoc.document options
# see RDoc::RDoc
# require 'rdoc'
#
# class RDoc::Parser::Xyz < RDoc::Parser
#   parse_files_matching /\.xyz$/
#
#   def initialize top_level, file_name, content, options, stats
#     super
#
#     # extra initialization if needed
#   end
# :
