class DocLoader
  def self.load(file_path, spec_path)
    raise ArgumentError unless file_path.is_a? String
    raise ArgumentError unless File.exist?(file_path)

    data =  File.readlines(file_path).map do |line|
              line.chomp
            end

    DocData.new(data)
  end
end
