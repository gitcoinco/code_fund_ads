FORMAT: 1A
HOST: api.condefund.app

# CodeFund Ads

# Advertisement [/properties/{property_id}/funder.html/?{template}{theme}{keywords}]

Returns an HTML fragment that you can add to your page.

→ __Your server code should do something similar to this__

```
require "open-uri"
response = open("https://api.codefund.app/1/funder.html")
@ad_html = response.read # place this HTML on your page somewhere
```

## Fetch for Property [GET]

  + Parameters
    + property_id (number, required) - The property id
      _will be deprecated on 2019-04-01_
    + template (enum[string], optional) - The ad template to use
      _overrides property config_
      + `bottom-bar`
      + `centered`
      + `default`
      + `horizontal`
      + `image-centered`
      + `image-only`
      + `square`
      + `vertical`
    + theme (enum[string], optional) - The ad theme to apply
      _overrides property config_
      + `dark`
      + `light`
    + keywords (enum[string], optional) - Comma delimited list of property keywords used to find a matching ad
      _overrides property config_
      + `ABAP`
      + `Ada`
      + `Alice`
      + `Android Development`
      + `Apex`
      + `Assembly language`
      + `Awk`
      + `Backend Services`
      + `Bash`
      + `Blockchain`
      + `C`
      + `C#`
      + `C++`
      + `COBOL`
      + `CSS & Design`
      + `Computer Science`
      + `D`
      + `Dart`
      + `Database`
      + `Delphi/Object Pascal`
      + `Dev Ops`
      + `Docker`
      + `Erlang`
      + `F#`
      + `Fortran`
      + `Frontend Concepts`
      + `Frontend Frameworks & Tools`
      + `Frontend Workflow & Tooling`
      + `Game Development`
      + `Git`
      + `Go`
      + `Groovy`
      + `HTML5`
      + `Haskell`
      + `Hybrid & Mobile Web`
      + `IOS Development`
      + `Java`
      + `JavaScript`
      + `Julia`
      + `LabVIEW`
      + `Ladder Logic`
      + `Languages & Frameworks`
      + `Lisp`
      + `Logo`
      + `Lua`
      + `MATLAB`
      + `MQL4`
      + `Objective-C`
      + `Other`
      + `PHP`
      + `PL/SQL`
      + `Perl`
      + `Prolog`
      + `Python`
      + `Q`
      + `R`
      + `RPG (OS/400)`
      + `React`
      + `Resources`
      + `Ruby`
      + `Rust`
      + `SAS`
      + `Scala`
      + `Scheme`
      + `Scratch`
      + `Shell`
      + `Swift`
      + `Transact-SQL`
      + `VHDL`
      + `Visual Basic`
      + `Visual Basic .NET`

+ Response 200 (text/html)

        <div id="cf" style="max-width: 330px; margin: 0 auto;"> <span> <span class="cf-wrapper" style="border-radius: 4px; padding: 15px; display: block; overflow: hidden; font-size: 14px; line-height: 1.4; text-align: left; background-color: rgba(0, 0, 0, 0.05); font-family: Helvetica;"> <a class="cf-img-wrapper" target="_blank" rel="noopener" style="float: left; margin-right: 15px;" href="http://localhost:3000/impressions/7ee965a5-e5b8-469a-afc8-f6b431b04aa6/click?campaign_id=126"></a> <a class="cf-text" target="_blank" rel="noopener" style="color: #333; text-decoration: none;" href="http://localhost:3000/impressions/7ee965a5-e5b8-469a-afc8-f6b431b04aa6/click?campaign_id=126"> <strong>Tired of being tracked?</strong> <span>CodeFund is a non-tracking ad platform that funds open source</span> </a> <a href="https://codefund.app" class="cf-powered-by" target="_blank" rel="noopener" style="margin-top: 5px; font-size: 12px; display: block; color: #777; text-decoration: none;"> <em>ethical</em> ad by CodeFund <img src="http://localhost:3000/display/7ee965a5-e5b8-469a-afc8-f6b431b04aa6.gif?template=default&amp;theme=light"> </a> </span> </span> </div>

+ Response 404 (text/html)

        CodeFund does not have a advertiser for you at this time.
