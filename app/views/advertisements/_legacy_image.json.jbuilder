# legacy api support
# TODO: deprecate legacy support on 2019-04-01
json.height image.metadata["height"].to_i
json.size_descriptor image.metadata["format"]
json.url image.cloudfront_url
json.width image.metadata["width"].to_i
