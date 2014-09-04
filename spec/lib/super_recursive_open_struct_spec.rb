require "super_recursive_open_struct"
require "rspec"

describe SuperRecursiveOpenStruct do

  describe "#initialize" do
    it "accepts nil" do
      expect { SuperRecursiveOpenStruct.new(nil) }.not_to raise_error
    end

    it "accepts an empty array" do
      sros = SuperRecursiveOpenStruct.new([])
      expect(sros.size).to eq 0
    end

    it "does raise on missing methods" do
      sros = SuperRecursiveOpenStruct.new(a: 1)
      expect { sros.baz }.to raise_error(NoMethodError)
    end

    context "with raise_on_missing_methods = false" do
      let(:args) { { raise_on_missing_methods: false } }

      it "does NOT raise on missing methods" do
        sros = SuperRecursiveOpenStruct.new({a: 1}, args)
        expect(sros.baz).to be nil
      end
    end
  end

  describe "#respond_to?" do
    it "is implemented properly with #respond_to_missing?" do
      sros = SuperRecursiveOpenStruct.new(a: 1)
      expect(sros.respond_to?(:a)).to be true
      expect(sros.respond_to?(:b)).to be false
    end
  end

  describe "#inspect" do
    it "returns the expected output" do
      sros = SuperRecursiveOpenStruct.new(a: { z: 9 }, b: 1)

      id = sros.object_id.to_s(16)
      string = "#<SuperRecursiveOpenStruct:0x#{id} a={:z=>9}, b=1>"
      expect(sros.inspect).to eq string
    end
  end

end
