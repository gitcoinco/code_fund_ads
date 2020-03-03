KW_MAP = {
  "ABAP" => nil,
  "Ada" => nil,
  "Alice" => nil,
  "Android Development" => "Android",
  "Apex" => nil,
  "Assembly language" => nil,
  "Awk" => nil,
  "Backend Services" => "Backend",
  "Bash" => nil,
  "Blockchain" => "Blockchain",
  "C" => "C",
  "C#" => "C#",
  "C++" => "C++",
  "COBOL" => nil,
  "CSS & Design" => "CSS & Design",
  "Computer Science" => nil,
  "D" => "D",
  "Dart" => "Dart",
  "Database" => "Database",
  "Delphi/Object Pascal" => nil,
  "Dev Ops" => "DevOps",
  "Docker" => "DevOps",
  "Erlang" => "Erlang",
  "F#" => "F#",
  "Fortran" => "Fortran",
  "Frontend Concepts" => "Frontend",
  "Frontend Frameworks & Tools" => "Frontend",
  "Frontend Workflow & Tooling" => "Frontend",
  "Game Development" => "Game Development",
  "Git" => nil,
  "Go" => "Go",
  "Groovy" => "Groovy",
  "HTML5" => nil,
  "Haskell" => "Haskell",
  "Hybrid & Mobile Web" => "Hybrid & Mobile Web",
  "IOS Development" => "iOS",
  "Java" => "Java",
  "JavaScript" => "JavaScript",
  "Julia" => "Julia",
  "LabVIEW" => nil,
  "Ladder Logic" => nil,
  "Languages & Frameworks" => nil,
  "Lisp" => nil,
  "Logo" => nil,
  "Lua" => nil,
  "MATLAB" => nil,
  "MQL4" => nil,
  "Objective-C" => "Objective-C",
  "Other" => "Other",
  "PHP" => "PHP",
  "PL/SQL" => "PL/SQL",
  "Perl" => nil,
  "Prolog" => nil,
  "Python" => "Python",
  "Q" => "Q",
  "R" => "R",
  "RPG (OS/400)" => nil,
  "React" => "React",
  "Resources" => "Developer Resources",
  "Ruby" => "Ruby",
  "Rust" => "Rust",
  "SAS" => nil,
  "Scala" => "Scala",
  "Scheme" => nil,
  "Scratch" => nil,
  "Shell" => nil,
  "Swift" => "Swift",
  "Transact-SQL" => nil,
  "VHDL" => nil,
  "Visual Basic" => nil,
  "Visual Basic .NET" => ".NET"
}

namespace :migrate do
  task keywords: :environment do
    Property.all.each do |property|
      keywords = property.keywords.map { |kw|
        KW_MAP[kw]
      }
      property.update(keywords: keywords.uniq.compact.sort)
    end

    Campaign.all.each do |campaign|
      keywords = campaign.keywords.map { |kw|
        KW_MAP[kw]
      }
      campaign.update(keywords: keywords.uniq.compact.sort)
    end

    puts "Done!"
  end
end
