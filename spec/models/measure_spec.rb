require "rails_helper"

RSpec.describe Measure, type: :model do
  describe "validations" do
    it { should validate_presence_of(:timestamp) }
    it { should validate_presence_of(:temperature) }
  end

  describe "associations" do
    it { should belong_to(:city) }
  end
end
