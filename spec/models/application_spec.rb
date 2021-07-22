require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

  before :each do
    @shelter1 = Shelter.create!(name: "Tre's Shelter", city: "Lakewood", rank: 1, foster_program: true)
    @shelter2 = Shelter.create!(name: "Boone's Shelter", city: "Lakewood", rank: 2, foster_program: false)

    @pet1 = Pet.create!(name: "Frank West", breed: "German Shepard", age: 2, adoptable: true, shelter_id: @shelter1.id)
    @pet2 = Pet.create!(name: "Paws", breed: "Yellow lab", age: 5, adoptable: false, shelter_id: @shelter2.id)
    @pet3 = Pet.create!(name: "Wishbone", breed: "Jack Russel", age: 3, adoptable: true, shelter_id: @shelter1.id)
    @pet4 = Pet.create!(name: "CoCo", breed: "Black lab", age: 6, adoptable: false, shelter_id: @shelter2.id)

    @application1 = Application.create!(name: "Greg", street_address: "1234 Love Dr", city: "Lakewood", state: "Co", zip_code: "80227", description: "I am a loving owner <3.", status: 0)
    @application2 = Application.create!(name: "Jojo", street_address: "5678", city: "Lakewood", state: "Co", zip_code: "80227", description: "I demand a dog now.", status: 0)
    @application3 = Application.create!(name: "Chase", street_address: "9101", city: "Lakewood", state: "Co", zip_code: "80227", description: "I have a house a job and can supply ", status: 0)
    @application4 = Application.create!(name: "Charlie", street_address: "1213", city: "Lakewood", state: "Co", zip_code: "80227", description: "I have a lovely home with a big backyard and am looking for someone to have fun with", status: 0)

    @pet_application1 = PetApplication.create!(application_id: @application1.id, pet_id: @pet1.id)
    @pet_application2 = PetApplication.create!(application_id: @application1.id, pet_id: @pet3.id)
    @pet_application3 = PetApplication.create!(application_id: @application2.id, pet_id: @pet1.id)
    @pet_application4 = PetApplication.create!(application_id: @application4.id, pet_id: @pet4.id)
  end

  # describe 'class methods' do
  #  describe '.' do
  #   end
  # end

  describe 'instance methods' do
    describe '#pet_count' do
      it 'can count the number of pets associated with the application' do

        expect(@application3.pet_count).to eq(0)
        expect(@application1.pet_count).to eq(2)
      end
    end
  end
end