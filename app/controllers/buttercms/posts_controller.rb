class Buttercms::PostsController < Buttercms::BaseController
  def index
    @posts = ButterCMS::Post.all(page: params[:page], page_size: 12)

    @next_page = @posts.meta.next_page
    @previous_page = @posts.meta.previous_page
  end

  def show
    @post = ButterCMS::Post.find(params[:slug])
    featured_image_slug = @post.featured_image.split("/").last
    transformations = [
      "resize=width:800",
    ]
    @body = @post.body
    @featured_image_url = "https://cdn.buttercms.com/#{transformations.join("/")}/#{featured_image_slug}"

    set_meta_tags(
      title: @post.title,
      description: @post.summary,
      keywords: @post.tags.map(&:name).join(", "),
      image_src: @post.featured_image,
      twitter: {
        card: "summary",
        site: "@codefundio",
      }
    )

    @next_post = @post.meta.next_post
    if @next_post
      next_post_featured_image_slug = @next_post.featured_image.split("/").last
      @next_post_image_url = "https://cdn.buttercms.com/resize=height:250,width:500,fit:scale/#{next_post_featured_image_slug}"
    end

    @previous_post = @post.meta.previous_post
    if @previous_post
      previous_post_featured_image_slug = @previous_post.featured_image.split("/").last
      @previous_post_image_url = "https://cdn.buttercms.com/resize=height:250,width:500,fit:scale/#{previous_post_featured_image_slug}"
    end
  end
end
