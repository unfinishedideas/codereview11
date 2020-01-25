require 'rails_helper'

describe "the edit product process" do
  
  before(:each) do
    Product.destroy_all
    Review.destroy_all
    User.destroy_all
    User.create!(:email => 'admin@admin.com', :password => '123', :password_confirmation => '123', :admin => true, :username => 'Admin Man')
  end

  def get_admin
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', :with => 'admin@admin.com'
    fill_in 'Password', :with => '123'
    click_on 'Log in'
  end

  it "edits a product name" do
    project = Product.create({name: "dope thing", cost: 5, country_of_origin: "USA" })
    get_admin
    visit products_path
    click_link('Dope Thing')
    click_link 'Edit properties'
    fill_in 'Name', :with => 'The Juicinator 3000'
    click_on 'Update Product'
    expect(page).to have_content 'Product successfully updated!'
    expect(page).to have_content 'The Juicinator 3000'
  end

  it "gives an error when no name is entered" do
    project = Product.create({name: "dope thing", cost: 5, country_of_origin: "USA" })
    get_admin
    visit products_path
    click_link('Dope Thing')
    click_link 'Edit properties'
    fill_in 'Name', :with => ''
    click_on 'Update Product'
    expect(page).to have_content "Name can't be blank"
  end
end
