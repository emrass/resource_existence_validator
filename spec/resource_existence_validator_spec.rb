require 'spec_helper'

describe ResourceExistenceValidator do
  let(:associatable) { Associatable.create }

  context "with no relation" do
    it "validates as false without allow_nil" do
      v = Validatable.new
      v.save.should be_false
    end

    it "validates as true with allow_nil" do
      v = ValidatableAllowNil.new
      v.save.should be_true
    end
  end

  context "with existing relation" do
    it "validates as true if the resource exists" do
      v = Validatable.new(associatable: associatable)
      v.should be_valid
    end

    it "validates as false if an invalid resource is set" do
      v = Validatable.new(associatable_id: 9999)
      v.should_not be_valid
    end
  end

  context "with a foreign name" do
    it "validates as true" do
      v = ValidatableForeignName.new(foreigner: associatable)
      v.should be_valid
    end
  end
end
