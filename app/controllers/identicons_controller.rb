class IdenticonsController < ApplicationController
  def show
    user = User.find(params[:user_id])
    cache_key = "#{user.cache_key}/identicon"
    base64_identicon = Rails.cache.fetch(cache_key, expires_in: 2.weeks) {
      RubyIdenticon.create_base64(user.email, border_size: 50, grid_size: 7, square_size: 50, background_color: 0xfafafaff)
    }
    send_data Base64.decode64(base64_identicon), type: "image/png", disposition: :inline
  end
end
