select
1 "id",
'United States and Canada' "name",
'USD' "blockchain_ecpm_currency", 1000 "blockchain_ecpm_cents",
'USD' "css_and_design_ecpm_currency", 450 "css_and_design_ecpm_cents",
'USD' "dev_ops_ecpm_currency", 650 "dev_ops_ecpm_cents",
'USD' "game_development_ecpm_currency", 425 "game_development_ecpm_cents",
'USD' "javascript_and_frontend_ecpm_currency", 625 "javascript_and_frontend_ecpm_cents",
'USD' "miscellaneous_ecpm_currency", 425 "miscellaneous_ecpm_cents",
'USD' "mobile_development_ecpm_currency", 450 "mobile_development_ecpm_cents",
'USD' "web_development_and_backend_ecpm_currency", 500 "web_development_and_backend_ecpm_cents",
'{US,CA}'::text[] "country_codes"

union all

select
2,
'Europe, Australia and New Zealand',
'USD', 900, -- blockchain
'USD', 350, -- css and design
'USD', 550, -- dev ops
'USD', 325, -- game development
'USD', 525, -- javascript
'USD', 325, -- miscellaneous
'USD', 350, -- mobile development
'USD', 400, -- web development
'{AD,AL,AT,AU,AX,BA,BE,BG,BY,CC,CH,CX,CZ,DE,DK,EE,ES,FI,FO,FR,GB,GG,GI,GR,HR,HU,IE,IM,IS,IT,JE,LI,LT,LU,LV,MC,MD,ME,MK,MT,NF,NL,NO,NZ,PL,PT,RO,RS,SE,SI,SJ,SK,SM,UA,VA}'::text[]

union all

select
3,
'Other',
'USD', 600, -- blockchain
'USD', 50,  -- css and design
'USD', 250, -- dev ops
'USD', 25,  -- game development
'USD', 225, -- javascript
'USD', 25,  -- miscellaneous
'USD', 50,  -- mobile development
'USD', 100, -- web development
'{AE,AF,AG,AI,AM,AO,AR,AS,AW,AZ,BB,BD,BF,BH,BI,BJ,BL,BM,BN,BO,BQ,BR,BS,BT,BW,BZ,CD,CF,CG,CI,CK,CL,CM,CN,CO,CR,CU,CV,CW,CY,DJ,DM,DO,DZ,EC,EG,EH,ER,ET,FJ,FK,FM,GA,GD,GE,GF,GH,GL,GM,GN,GP,GQ,GS,GT,GU,GW,GY,HK,HN,HT,ID,IL,IN,IO,IQ,IR,JM,JO,JP,KE,KG,KH,KI,KM,KN,KP,KR,KW,KY,KZ,LA,LB,LC,LK,LR,LS,LY,MA,MF,MG,MH,ML,MM,MN,MO,MP,MQ,MR,MS,MU,MV,MW,MX,MY,MZ,NA,NC,NE,NG,NI,NP,NR,NU,OM,PA,PE,PF,PG,PH,PK,PM,PN,PR,PS,PW,PY,QA,RE,RU,RW,SA,SB,SC,SD,SG,SH,SL,SN,SO,SR,SS,ST,SV,SX,SY,SZ,TC,TD,TG,TH,TJ,TK,TL,TM,TN,TO,TR,TT,TV,TW,TZ,UG,UM,UY,UZ,VC,VE,VG,VI,VN,VU,WF,WS,YE,YT,ZA,ZM,ZW}' "country_codes"
