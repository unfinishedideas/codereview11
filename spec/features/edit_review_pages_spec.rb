describe "the add a review process" do
  before(:each) do
    # Product.destroy_all
    # Review.destroy_all
    # User.destroy_all
    User.create!(:email => 'admin@admin.com', :password => '123', :password_confirmation => '123', :admin => true, :username => 'Admin Man')
    # Product.create({name: "dope thing", cost: 5, country_of_origin: "USA" })
  end

  def get_admin
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', :with => 'admin@admin.com'
    fill_in 'Password', :with => '123'
    click_on 'Log in'
  end

  def make_review
    visit products_path
    click_link 'Dope Thing'
    click_link 'Review this product'
    fill_in 'Rating', :with => 5
    fill_in 'review_content_body', :with => "USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA USA"
    click_on 'Create Review'
  end

  it "edits a review product" do
    product = Product.create({name: "dope thing", cost: 5, country_of_origin: "USA" })
    get_admin
    make_review
    visit products_path
    click_link 'Dope Thing'
    click_link 'Admin Man'
    click_link 'Edit review'
    fill_in 'review_content_body', :with => 'Standup Sally salaciously soliticed Stan somewhat strangely. OKAY?'
    click_on 'Update Review'
    expect(page).to have_content 'Review successfully updated!'
    expect(page).to have_content('Standup Sally salaciously soliticed Stan somewhat strangely. OKAY')
  end

  it "gives an error when no name is entered" do
    product = Product.create({name: "dope thing", cost: 5, country_of_origin: "USA" })
    get_admin
    make_review
    visit products_path
    click_link 'Dope Thing'
    click_link 'Admin Man'
    click_link 'Edit review'
    fill_in 'review_content_body', :with => ''
    click_on 'Update Review'
    expect(page).to have_content "Content body can't be blank"
  end
end
