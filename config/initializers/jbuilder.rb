# configure all JSON rendered with Jbuilder to return camelCase keys
# this allows us to keep pretty snake_case keys in ruby land while providing javscript land with camelCase
# TODO: turn this global config on after legacy api support has been removed on 2019-04-01
# Jbuilder.key_format camelize: :lower
