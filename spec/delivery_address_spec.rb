require "spec_helper"

describe WavesUtilities::DeliveryAddress do
  context "#new" do
    subject { described_class.new(input_params) }

    context "in general" do
      let(:input_params) do
        { name: "A real name", non_existent: "rubbish" }
      end

      it "has a name" do
        expect(subject.name).to eq("A real name")
      end

      it "does not have non_existent" do
        expect { subject.non_existent }.to raise_error(NoMethodError)
      end
    end

    context "#inline_address" do
      let(:input_params) do
        {
          address_1: "10 DOWNING ST",
          address_2: "WHITEHALL",
          town: "LONDON",
        }
      end

      it "rendes the expected address fields" do
        expect(subject.inline_address)
          .to eq("10 DOWNING ST, WHITEHALL, LONDON")
      end
    end
  end

  context "#assign_attributes" do
    let(:owner) { described_class.new }

    before do
      owner.assign_attributes(address_1: "My house", foo: "some rubbish")
    end

    it "updates the owner name" do
      expect(owner.address_1).to eq("My house")
    end
  end

  context "::ATTRIBUTES" do
    it { expect(WavesUtilities::DeliveryAddress::ATTRIBUTES).to include(:name) }
  end
end
