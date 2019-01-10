require "rails_helper"

describe "visitor" do
  it "can see all api endpoints" do
    visit welcome_path

    expect(page).to have_content("Welcome")
  end
end
