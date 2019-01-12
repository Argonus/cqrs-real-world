require "rails_helper"

RSpec.describe "Publish Blog Process" do
  it "publishes blog when blog is created and any article published" do
    blog_user = ::BlogManagement::UserReadModel.create!(name: "Name")
    blog_article = ::BlogManagement::ArticleReadModel.create!(title: "A", user_id: blog_user.id)

    blog_id = SecureRandom.uuid

    command_bus.call(Blogging::BlogCreateCommand.new(
      blog_id: blog_id,
      name: "Random",
      user_id: blog_user.id
    ))

    blog = BlogManagement::BlogReadModel.find_by(id: blog_id)

    expect(blog.published).to be_nil

    command_bus.call(Blogging::ArticlePublishCommand.new(
      blog_id: blog_id,
      article_id: blog_article.id,
      user_id: blog_user.id
    ))

    blog_article.reload
    blog.reload

    expect(blog_article.state).to eq "published"
    expect(blog.published).to be_truthy
  end

  def command_bus
    Rails.configuration.command_bus
  end
end