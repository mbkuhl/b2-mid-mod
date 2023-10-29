require "rails_helper"

RSpec.describe Employee, type: :feature do
  before :each do
    @department1 = Department.create!(name: "IT", floor: "Basement")
    @department2 = Department.create!(name: "HR", floor: "The real Basement")
    @employee1 = @department1.employees.create!(name: "Mike", level: "1")
    @employee2 = @department1.employees.create!(name: "Bob", level: "2")
    @employee3 = @department2.employees.create!(name: "Jim", level: "3")
    @ticket1 = @employee1.tickets.create!(subject: "Fix 1", age: "1")
    @ticket2 = @employee1.tickets.create!(subject: "Fix 2", age: "2")
    @ticket3 = @employee1.tickets.create!(subject: "Fix 3", age: "3")
    @ticket4 = @employee2.tickets.create!(subject: "Fix 4", age: "4")
    @ticket5 = @employee2.tickets.create!(subject: "Fix 5", age: "5")
    @ticket6 = @employee3.tickets.create!(subject: "Fix 6", age: "6")
  end


  describe "As a user, when I visit the employee show page" do
    it "I see the employees name, their department," do
      visit "/employees/#{@employee1.id}"
      
      expect(page).to have_content("Mike")
      expect(page).to have_content("IT")
      
      visit "/employees/#{@employee3.id}"
      expect(page).to have_content("Jim")
      expect(page).to have_content("HR")

    end
    
    it "I see a list of all their tickets from oldest to newest, with their oldest ticket listed separately" do
      visit "/employees/#{@employee1.id}"

      within "#AllTickets" do
        expect("Fix 3").to appear_before("Fix 2")
        expect("Fix 2").to appear_before("Fix 1")
      end

      within "#OldestTicket" do
        expect(page).to have_content("Fix 3")
      end
    end

    it "I do not see any tickets that are not assigned to the employee" do
      visit "/employees/#{@employee1.id}"
      
      expect(page).to_not have_content("Fix 4")
      expect(page).to_not have_content("Fix 5")
      expect(page).to_not have_content("Fix 6")
      
      visit "/employees/#{@employee3.id}"
      expect(page).to_not have_content("Fix 1")
      expect(page).to_not have_content("Fix 2")
      expect(page).to_not have_content("Fix 3")
      expect(page).to_not have_content("Fix 4")
      expect(page).to_not have_content("Fix 5")
    end

    describe "I see a form to add a ticket to this employee" do
      describe "When I fill in the form with the id of a ticket that already exists in the database and I click submit" do
        it "Then I am redirected back to that employees show page where I see the ticket's subject now listed" do
          visit "/employees/#{@employee1.id}"
          fill_in(:add_ticket, with: "#{@ticket4.id}")
          click_button("Add ticket")

          expect(current_path).to eq("/employees/#{@employee1.id}")
          expect(page).to have_content("Fix 4")
          expect(page).to_not have_content("Fix 5")
          expect(page).to_not have_content("Fix 6")

          fill_in(:add_ticket, with: "#{@ticket6.id}")
          click_button("Add ticket")

          expect(current_path).to eq("/employees/#{@employee1.id}")
          expect(page).to have_content("Fix 4")
          expect(page).to_not have_content("Fix 5")
          expect(page).to have_content("Fix 6")

        end
      end
    end

    it "I see that employees name and level, and I see a unique list of all the other employees that this employee shares tickets with" do
      visit "/employees/#{@employee1.id}"
      expect(page).to have_content("Level: 1")


      expect(page).to have_content("Working with:")
      expect(page).to_not have_content("Jim")
      expect(page).to_not have_content("Bob")
      
      fill_in(:add_ticket, with: "#{@ticket4.id}")
      click_button("Add ticket")
      expect(page).to have_content("Working with:")
      expect(page).to have_content("Bob")
      expect(page).to_not have_content("Jim")
      
      fill_in(:add_ticket, with: "#{@ticket6.id}")
      click_button("Add ticket")
      save_and_open_page
      within "#WorkingWith" do
        expect(page).to have_content("Working with:")
        expect(page).to have_content("Jim")
        expect(page).to have_content("Bob")
        expect(page).to_not have_content("Mike")
      end
    end
  end
end