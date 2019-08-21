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

  BLOCKCHAIN = new(
    name: "Blockchain",
    keywords: ["Blockchain", "Cryptography"]
  )

  DATA_SCIENCE = new(
    name: "Data Science",
    keywords: ["Database", "Julia", "Machine Learning", "PL/SQL", "Python", "R"]
  )

  DEV_OPS = new(
    name: "DevOps",
    keywords: ["Backend", "DevOps", "IoT", "Ruby", "Python", "Security", "Serverless"]
  )

  FRONT_END_DEVELOPMENT = new(
    name: "Front End Development",
    keywords: ["Angular", "Dart", "Frontend", "JavaScript", "React", "VueJS"]
  )

  GAME_DEVELOPMENT = new(
    name: "Game Development",
    keywords: ["Game Development", "Virtual Reality"]
  )

  JAVA_SCRIPT = new(
    name: "JavaScript",
    keywords: ["JavaScript"]
  )

  MOBILE_DEVELOPMENT = new(
    name: "Mobile Development",
    keywords: ["Android", "Hybrid & Mobile Web", "iOS", "Kotlin", "Objective-C", "Swift"]
  )

  SYSTEMS_DEVELOPMENT = new(
    name: "Systems Development",
    keywords: [".NET", "Backend", "C", "D", "Erlang", "F#", "Go", "Haskell", "Java", "Q", "Rust", "Scala"]
  )

  USER_INTERFACE_DESIGN = new(
    name: "User Interface Design",
    keywords: ["CSS & Design"]
  )

  WEB_DEVELOPMENT = new(
    name: "Web Development",
    keywords: [".NET", "Backend", "Developer Resources", "Groovy", "JavaScript", "Other", "PHP", "Python", "Ruby"]
  )

  class << self
    def all
      [
        BLOCKCHAIN,
        DATA_SCIENCE,
        DEV_OPS,
        FRONT_END_DEVELOPMENT,
        GAME_DEVELOPMENT,
        JAVA_SCRIPT,
        MOBILE_DEVELOPMENT,
        SYSTEMS_DEVELOPMENT,
        USER_INTERFACE_DESIGN,
        WEB_DEVELOPMENT,
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
        preferred = max_matches.find { |match| match[:audience] == Audience::WEB_DEVELOPMENT }
        max = preferred if preferred
      end
      if max[:ratio].zero?
        max = all_matches.find { |match| match[:audience] == Audience::WEB_DEVELOPMENT }
      end
      max[:audience]
    end
  end
end
