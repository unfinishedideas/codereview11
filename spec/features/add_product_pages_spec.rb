require 'rails_helper'

describe "the add a product process" do

  before(:each) do
    User.create!(:email => 'admin@admin.com', :password => '123', :password_confirmation => '123', :admin => true, :username => 'Admin Man')
  end

  def get_admin
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', :with => 'admin@admin.com'
    fill_in 'Password', :with => '123'
    click_on 'Log in'
  end

  it "adds a new product" do
    visit '/'
    get_admin
    visit products_path
    click_link 'Create new product'
    fill_in 'Name', :with => 'The Juicinator 3000'
    fill_in 'Cost', :with => 350
    fill_in 'Country of origin', :with => "USA"
    click_on 'Create Product'
    expect(page).to have_content 'Product successfully added!'
    expect(page).to have_content('The Juicinator 3000')
  end

  it "gives an error when no name is entered" do
    get_admin
    visit new_product_path
    click_on 'Create Product'
    expect(page).to have_content "Name can't be blank"
  end
end
