# Supported Keywords
# - .NET
# - Android
# - Angular
# - Backend
# - Blockchain
# - C
# - CSS & Design
# - Cryptography
# - D
# - Dart
# - Database
# - DevOps
# - Developer Resources
# - Erlang
# - F#
# - Frontend
# - Game Development
# - Go
# - Groovy
# - Haskell
# - Hybrid & Mobile Web
# - iOS
# - IoT
# - Java
# - JavaScript
# - Julia
# - Kotlin
# - Machine Learning
# - Objective-C
# - Other
# - PHP
# - PL/SQL
# - Python
# - Q
# - R
# - React
# - Ruby
# - Rust
# - Scala
# - Security
# - Serverless
# - Swift
# - Virtual Reality
# - VueJS
class Audience
  include ActiveModel::Model

  attr_accessor :name, :keywords

  def initialize(*args)
    super
    keywords.freeze
  end

  BLOCKCHAIN = new(
    name: "Blockchain",
    keywords: %w[
      Blockchain
      Cryptography
    ]
  )

  CSS_AND_DESIGN = new(
    name: "CSS & Design",
    keywords: ["CSS & Design"]
  )

  DEV_OPS = new(
    name: "DevOps",
    keywords: %w[
      DevOps
      Python
      Ruby
      Security
      Serverless
    ]
  )

  GAME_DEVELOPMENT = new(
    name: "Game Development",
    keywords: [
      "Game Development",
      "Virtual Reality",
    ]
  )

  JAVA_SCRIPT_AND_FRONTEND = new(
    name: "JavaScript & Frontend",
    keywords: %w[
      Angular
      Dart
      Frontend
      JavaScript
      React
      VueJS
    ]
  )

  MISCELLANEOUS = new(
    name: "Miscellaneous",
    keywords: [
      "C",
      "D",
      "Developer Resources",
      "Erlang",
      "F#",
      "Haskell",
      "IoT",
      "Julia",
      "Machine Learning",
      "Other",
      "Python",
      "Q",
      "R",
      "Rust",
      "Scala",
    ]
  )

  MOBILE_DEVELOPMENT = new(
    name: "Mobile Development",
    keywords: [
      "Android",
      "Hybrid & Mobile Web",
      "Kotlin",
      "Objective-C",
      "Swift",
      "iOS",
    ]
  )

  WEB_DEVELOPMENT_AND_BACKEND = new(
    name: "Web Development & Backend",
    keywords: %w[
      .NET
      Backend
      Database
      Go
      Groovy
      Java
      PHP
      PL/SQL
      Python
      Ruby
    ]
  )

  class << self
    def all
      [
        BLOCKCHAIN,
        CSS_AND_DESIGN,
        DEV_OPS,
        GAME_DEVELOPMENT,
        JAVA_SCRIPT_AND_FRONTEND,
        MISCELLANEOUS,
        MOBILE_DEVELOPMENT,
        WEB_DEVELOPMENT_AND_BACKEND,
      ]
    end

    def matches(keywords = [])
      all.map do |audience|
        matched_keywords = audience.keywords & keywords
        {
          audience: audience,
          matched_keywords: matched_keywords,
          ratio: keywords.size.zero? ? 0 : matched_keywords.size / keywords.size.to_f,
        }
      end
    end

    def match(keywords = [])
      all_matches = matches(keywords)
      max = all_matches.max_by { |match| match[:ratio] }
      max_matches = all_matches.select { |match| match[:ratio] == max[:ratio] }
      if max_matches.size > 1
        preferred = max_matches.find { |match| match[:audience] == Audience::WEB_DEVELOPMENT_AND_BACKEND } if max_matches.include?(Audience::WEB_DEVELOPMENT_AND_BACKEND)
        preferred = max_matches.find { |match| match[:audience] == Audience::JAVA_SCRIPT_AND_FRONTEND } if max_matches.include?(Audience::JAVA_SCRIPT_AND_FRONTEND)
        max = preferred if preferred
      end
      if max[:ratio].zero?
        max = all_matches.find { |match| match[:audience] == Audience::MISCELLANEOUS }
      end
      max[:audience]
    end
  end
end
