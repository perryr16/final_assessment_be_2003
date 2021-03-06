require 'rails_helper'

RSpec.describe Hospital, type: :model do
  describe "relationships" do
    it {should have_many :doctors}
  end
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end
  describe "model methods" do
    before :each do
      @hospital1 = Hospital.create(name:"Grey Sloan Memorial Hospital", address:"123 Save Lives Rd", city: "Seattle", state: "WA", zip: "98101" )
      @hospital2 = Hospital.create(name:"Seaside Health & Wellness Center", address:"123 Private Practice Road", city: "Los Angeles", state: "CA", zip: "90001" )

      @doctor1 = @hospital1.doctors.create(name: "Meredith Grey1", specialty: "General Surgery", education: "Harvard University")
      @doctor2 = @hospital1.doctors.create(name: "N2", specialty: "S1", education: "Boston University")
      @doctor3 = @hospital1.doctors.create(name: "N3", specialty: "S2", education: "Harvard University")
      @doctor4 = @hospital1.doctors.create(name: "N4", specialty: "S3", education: "Turing")
      @doctor5 = @hospital2.doctors.create(name: "Alex Karev", specialty: "Pediatric Surgery", education: "Johns Hopkins University")
    
      @patient1 = Patient.create(name: "Katie Bryce", age: 24)
      @patient2 = Patient.create(name: "Denny Duquette", age: 39)
      @patient3 = Patient.create(name: "Rebecca Pope", age: 32)
      @patient4 = Patient.create(name: "Zola  Shepherd", age: 2)

      @doctor1.patients << @patient1
      @doctor2.patients << @patient2
      @doctor2.patients << @patient3
      @doctor5.patients << @patient4
    end
    it ".doctor_count" do
      expect(@hospital1.doctor_count).to eq(4)
    end
    it ".uniq_education" do
      expected = "Boston University, Harvard University, Turing"
      expect(@hospital1.uniq_education).to eq(expected)
    end
    it ".patients_by_age" do
      expected = ["Denny Duquette", "Rebecca Pope", "Katie Bryce"]
      expect(@hospital1.patients_by_age).to eq(expected)
    end
    
    
  end
  
  
end