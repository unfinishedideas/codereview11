require 'rails_helper'

describe "the add a review process" do

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

  it "adds a review to a product" do
    project = Product.create({name: "dope thing", cost: 5, country_of_origin: "USA" })
    get_admin
    visit products_path
    click_link 'Dope Thing'
    click_link 'Review this product'
    fill_in 'Rating', :with => 5
    fill_in 'review_content_body', :with => "USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA"
    click_on 'Create Review'
    expect(page).to have_content 'Review successfully added!'
    expect(page).to have_content('USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA')
  end

  it "gives an error when no name is entered" do
    project = Product.create({name: "dope thing", cost: 5, country_of_origin: "USA" })
    get_admin
    visit products_path
    click_link 'Dope Thing'
    click_link 'Review this product'
    fill_in 'Rating', :with => 5
    fill_in 'review_content_body', :with => ""
    click_on 'Create Review'
    save_and_open_page
    expect(page).to have_content "Author can't be blank"
  end
end
