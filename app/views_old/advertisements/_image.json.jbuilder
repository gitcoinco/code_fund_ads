json.key_format! camelize: :lower # TODO: remove this line in favor of global setting at config/jbuilder.rb after legacy support has been removed on 2019-04-01
json.url image.cloudfront_url
json.width image.metadata["width"].to_i
json.height image.metadata["height"].to_i
json.format image.metadata["format"] # small, large, wide, etc...
