describe OhHey do

	describe "#my_test" do
		it "takes input type String" do
			expect{ my_test( String.new ) }.not_to raise_error
		end

		it "outputs a Bool" do
			expect(my_test( String.new )).to be_a(Bool)
		end

	end

	describe "#my_test2" do
		it "takes input type Array" do
			expect{ my_test2( Array.new ) }.not_to raise_error
		end

		it "takes input type String" do
			expect{ my_test2( String.new ) }.not_to raise_error
		end

		it "outputs a Double" do
			expect(my_test2( Array.new, String.new )).to be_a(Double)
		end

	end

	describe "#my_test3" do
		it "takes input type Hash" do
			expect{ my_test3( Hash.new ) }.not_to raise_error
		end

		it "takes input type String" do
			expect{ my_test3( String.new ) }.not_to raise_error
		end

		it "outputs a Hash" do
			expect(my_test3( Hash.new, String.new )).to be_a(Hash)
		end

	end

	describe "#my_test4" do
		it "takes input type Integer" do
			expect{ my_test4( Integer.new ) }.not_to raise_error
		end

		it "outputs a Array" do
			expect(my_test4( Integer.new )).to be_a(Array)
		end

	end

end
