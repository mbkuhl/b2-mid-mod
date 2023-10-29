require "rails_helper"

RSpec.describe Department, type: :model do
  describe "relationships" do
    it { should have_many :employees }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:floor) }
  end

  before :each do
    @department1 = Department.create!(name: "IT", floor: "Basement")
    @department2 = Department.create!(name: "HR", floor: "The real Basement")
    @employee1 = @department1.employees.create!(name: "Mike", level: "1")
    @employee1 = @department1.employees.create!(name: "Bob", level: "2")
    @employee1 = @department2.employees.create!(name: "Jim", level: "3")
  end
end