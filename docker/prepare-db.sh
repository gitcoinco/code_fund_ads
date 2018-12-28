#! /bin/sh

# If database exists, migrate. Otherweise create and seed
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup db:seed
echo "Done!"