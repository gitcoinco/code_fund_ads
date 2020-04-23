class EricMailbox < ApplicationMailbox
  def process
    binding.pry
    puts "PROCESSING! #{mail.inspect}"
  end
end
