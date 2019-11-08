FORMAT: 1A9
HOST: api.codefund.app

# CodeFund Ads

This document is hosted at Apiary: https://codefund.docs.apiary.io/

# Advertisement HTML [/properties/{property_id}/funder.html/?{template}{theme}{keywords}]

Returns an HTML fragment that you can add to your page.

↓ _Your server code should do something similar to the example below._

```
require "open-uri"
response = open("https://api.codefund.app/properties/1/funder.html")
@ad_html = response.read # place this HTML on your page somewhere
```

↓ _Your client SPA code should do something similar to the example below._

```
const axios = require('axios');

axios.get('https://api.codefund.app/properties/1/funder.html')
  .then(function (response) {
    document.getElementById("codefund").innerHTML = response.data;
  });
```

## Fetch Ad HTML for Property [GET]

  + Parameters
    + property_id (number, required) - The property id
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
      + `unstyled` - exclude styles, only HTML
    + keywords (enum[string], optional) - Comma delimited list of property keywords used to find a matching ad
      _overrides property config_
      + `.NET`
      + `Android`
      + `Angular`
      + `Backend`
      + `Blockchain`
      + `C`
      + `Cryptography`
      + `CSS & Design`
      + `D`
      + `Dart`
      + `Database`
      + `Developer Resources`
      + `DevOps`
      + `Erlang`
      + `F#`
      + `Frontend`
      + `Game Development`
      + `Go`
      + `Groovy`
      + `Haskell`
      + `Hybrid & Mobile Web`
      + `iOS`
      + `IoT`
      + `Java`
      + `JavaScript`
      + `Julia`
      + `Kotlin`
      + `Machine Learning`
      + `Objective-C`
      + `Other`
      + `PHP`
      + `PL/SQL`
      + `Python`
      + `Q`
      + `R`
      + `React`
      + `Ruby`
      + `Rust`
      + `Scala`
      + `Security`
      + `Serverless`
      + `Swift`
      + `Virtual Reality`
      + `VueJS`

+ Response 200 (text/html)

        <div id="cf" style="max-width: 330px; margin: 0 auto;"> <span> <span class="cf-wrapper" style="border-radius: 4px; padding: 15px; display: block; overflow: hidden; font-size: 14px; line-height: 1.4; text-align: left; background-color: rgba(0, 0, 0, 0.05); font-family: Helvetica;"> <a class="cf-img-wrapper" target="_blank" rel="noopener" style="float: left; margin-right: 15px;" href="https://codefund.app/impressions/7ee965a5-e5b8-469a-afc8-f6b431b04aa6/click?campaign_id=126"></a> <a class="cf-text" target="_blank" rel="noopener" style="color: #333; text-decoration: none;" href="https://codefund.app/impressions/7ee965a5-e5b8-469a-afc8-f6b431b04aa6/click?campaign_id=126"> <strong>Tired of being tracked?</strong> <span>CodeFund is a non-tracking ad platform that funds open source</span> </a> <a href="https://codefund.app" class="cf-powered-by" target="_blank" rel="noopener" style="margin-top: 5px; font-size: 12px; display: block; color: #777; text-decoration: none;"> <em>ethical</em> ad by CodeFund <img src="https://codefund.app/display/7ee965a5-e5b8-469a-afc8-f6b431b04aa6.gif?template=default&amp;theme=light"> </a> </span> </span> </div>

+ Response 404 (text/html)

        CodeFund does not have an advertiser for you at this time.

# Advertisement JSON [/properties/{property_id}/funder.json/?{template}{theme}{keywords}]

## Fetch Ad JSON for Property [GET]

  + Parameters
    + property_id (number, required) - The property id
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
      + `unstyled` - exclude styles, only HTML
    + keywords (enum[string], optional) - Comma delimited list of property keywords used to find a matching ad
      _overrides property config_
      + `.NET`
      + `Android`
      + `Angular`
      + `Backend`
      + `Blockchain`
      + `C`
      + `Cryptography`
      + `CSS & Design`
      + `D`
      + `Dart`
      + `Database`
      + `Developer Resources`
      + `DevOps`
      + `Erlang`
      + `F#`
      + `Frontend`
      + `Game Development`
      + `Go`
      + `Groovy`
      + `Haskell`
      + `Hybrid & Mobile Web`
      + `iOS`
      + `IoT`
      + `Java`
      + `JavaScript`
      + `Julia`
      + `Kotlin`
      + `Machine Learning`
      + `Objective-C`
      + `Other`
      + `PHP`
      + `PL/SQL`
      + `Python`
      + `Q`
      + `R`
      + `React`
      + `Ruby`
      + `Rust`
      + `Scala`
      + `Security`
      + `Serverless`
      + `Swift`
      + `Virtual Reality`
      + `VueJS`

+ Response 200 (application/json)

        {
          "campaignUrl": "https://codefund.app/impressions/4737f03b-3e78-4a8c-a5ba-ba8b4f41ed80/click?campaign_id=144",
          "impressionUrl": "https://codefund.app/display/4737f03b-3e78-4a8c-a5ba-ba8b4f41ed80.gif?template=default&theme=light",
          "codefundUrl": "https://codefund.app",
          "fallback": true,
          "headline": "Why CodeFund?",
          "body": "🍪 Because cookies should come from your grandma, not from ads",
          "images": [
            {
              "url": "https://d3a2el5l1ud3kv.cloudfront.net/5hswXFgp9Mkwacdqhw5sc4cy",
              "width": 200,
              "height": 200,
              "format": "small"
            },
            {
              "url": "https://d3a2el5l1ud3kv.cloudfront.net/fLt4UvyyuExewym5KBoA7Yjp",
              "width": 512,
              "height": 320,
              "format": "wide"
            },
            {
              "url": "https://d3a2el5l1ud3kv.cloudfront.net/828gHMndjM3zyzDsuN9FdE1j",
              "width": 260,
              "height": 200,
              "format": "large"
            }
          ],
          "html": "<div id=\"cf\" style=\"max-width: 330px; margin: 0 auto;\"> <span> <span class=\"cf-wrapper\" style=\"border-radius: 4px; padding: 15px; display: block; overflow: hidden; font-size: 14px; line-height: 1.4; text-align: left; background-color: rgba(0, 0, 0, 0.05); font-family: Helvetica;\"> <a class=\"cf-img-wrapper\" target=\"_blank\" rel=\"noopener\" style=\"float: left; margin-right: 15px;\" href=\"https://codefund.app/impressions/4737f03b-3e78-4a8c-a5ba-ba8b4f41ed80/click?campaign_id=144\"> <img border=\"0\" height=\"100\" width=\"130\" class=\"cf-img\" src=\"https://d3a2el5l1ud3kv.cloudfront.net/828gHMndjM3zyzDsuN9FdE1j\" style=\"vertical-align: middle; max-width: 130px; border: none;\"> </a> <a class=\"cf-text\" target=\"_blank\" rel=\"noopener\" style=\"color: #333; text-decoration: none;\" href=\"https://codefund.app/impressions/4737f03b-3e78-4a8c-a5ba-ba8b4f41ed80/click?campaign_id=144\"> <strong>Why CodeFund?</strong> <span>🍪 Because cookies should come from your grandma, not from ads</span> </a> <a href=\"https://codefund.app\" class=\"cf-powered-by\" target=\"_blank\" rel=\"noopener\" style=\"margin-top: 5px; font-size: 12px; display: block; color: #777; text-decoration: none;\"> <em>ethical</em> ad by CodeFund <img src=\"https://codefund.app/display/4737f03b-3e78-4a8c-a5ba-ba8b4f41ed80.gif?template=default&amp;theme=light\"> </a> </span> </span> </div>"
        }

+ Response 404 (text/html)

        {
          "message": "CodeFund does not have an advertiser for you at this time."
        }

# Legacy Impression [/api/v1/impression/{legacy_property_id}]

Support for the [legacy API](https://github.com/gitcoinco/codefund/wiki/API-Documentation) semantics to "create an impression".

"Creating an impression" is a misnomer because this endpoint actually fetches an advertisement.
_An impression is only created if/when the advertisement is successfully rendered on your site._

⚠️ This endpoint will be __deprecated on 2019-04-01__. Please update to [GET Advertisement](https://codefund.docs.apiary.io/#reference/0/advertisement).

## Fetch Ad for Property [POST]

  + Parameters
    + legacy_property_id (string, required) - The property id from CodeFund v1

+ Response 200 (application/json)

        {
          "description": "Real-time error monitoring, alerting, and analytics for JavaScript developers",
          "headline": "Rollbar",
          "large_image_url": "https://d3a2el5l1ud3kv.cloudfront.net/twJCRNX7Xo4dtXBtrb1KN2YW",
          "reason": null,
          "images": [
            {
              "height": 100,
              "size_descriptor": "small",
              "url": "https://d3a2el5l1ud3kv.cloudfront.net/vSUN26HTBBwpYLxjhR8a2iPB",
              "width": 100
            },
            {
              "height": 200,
              "size_descriptor": "large",
              "url": "https://d3a2el5l1ud3kv.cloudfront.net/twJCRNX7Xo4dtXBtrb1KN2YW",
              "width": 260
            },
            {
              "height": 320,
              "size_descriptor": "wide",
              "url": "https://d3a2el5l1ud3kv.cloudfront.net/97y1PDDZjyGsN6xgtu1PRbme",
              "width": 512
            }
          ],
          "link": "https://codefund.app/impressions/e8d310c7-3541-4eb7-923a-722f7f91812d/click?campaign_id=136",
          "pixel": "https://codefund.app/display/e8d310c7-3541-4eb7-923a-722f7f91812d.gif?template=default&theme=light",
          "poweredByLink": "https://codefund.app",
          "small_image_url": "https://d3a2el5l1ud3kv.cloudfront.net/vSUN26HTBBwpYLxjhR8a2iPB",
          "house_ad": false
        }

+ Response 404 (application/json)

        {
          "small_image_url": "",
          "reason": "CodeFund does not have an advertiser for you at this time.",
          "poweredByLink": "https://codefund.app",
          "pixel": "",
          "link": "",
          "large_image_url": "",
          "images": [],
          "house_ad": false,
          "headline": "",
          "description": ""
        }
