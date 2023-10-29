require "rails_helper"

RSpec.describe Department, type: :feature do
  before :each do
    @department1 = Department.create!(name: "IT", floor: "Basement")
    @department2 = Department.create!(name: "HR", floor: "The real Basement")
    @employee1 = @department1.employees.create!(name: "Mike", level: "1")
    @employee2 = @department1.employees.create!(name: "Bob", level: "2")
    @employee3 = @department2.employees.create!(name: "Jim", level: "3")
  end


  describe "As a user, when I visit the apartment indx page" do
    it "I see each departments name and floor" do
      visit "/departments"
      
      within "#IT" do
        expect(page).to have_content("Department: IT")
        expect(page).to have_content("Floor: Basement")
      end
      within "#HR" do
        expect(page).to have_content("Department: HR")
        expect(page).to have_content("Floor: The real Basement")
      end
    end
    
    it "And underneath each department, I can see the name of all its employees" do
      visit "/departments"
      
      within "#IT" do
        expect(page).to have_content("Mike")
        expect(page).to have_content("Bob")
        expect(page).to_not have_content("Jim")
      end
      within "#HR" do
        expect(page).to have_content("Jim")
        expect(page).to_not have_content("Mike")
        expect(page).to_not have_content("Bob")
      end
    end
  end
end