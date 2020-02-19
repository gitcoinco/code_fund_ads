-- [ 1] Africa
-- [ 2] Americas - Central and Southern
-- [ 3] Americas - Northern
-- [ 4] Asia - Central and South-Eastern
-- [ 5] Asia - Eastern
-- [ 6] Asia - Southern and Western
-- [ 7] Australia and New Zealand
-- [ 8] Europe
-- [ 9] Europe - Eastern
-- [10] Other

select
1 "id",
'Africa' "name",
'USD' "blockchain_ecpm_currency", 75 "blockchain_ecpm_cents",
'USD' "css_and_design_ecpm_currency", 38 "css_and_design_ecpm_cents",
'USD' "dev_ops_ecpm_currency", 53 "dev_ops_ecpm_cents",
'USD' "game_development_ecpm_currency", 38 "game_development_ecpm_cents",
'USD' "javascript_and_frontend_ecpm_currency", 68 "javascript_and_frontend_ecpm_cents",
'USD' "miscellaneous_ecpm_currency", 23 "miscellaneous_ecpm_cents",
'USD' "mobile_development_ecpm_currency", 38 "mobile_development_ecpm_cents",
'USD' "web_development_and_backend_ecpm_currency", 45 "web_development_and_backend_ecpm_cents",
'{AO,BF,BI,BJ,BW,CD,CF,CG,CI,CM,CV,DJ,DZ,EG,EH,ER,ET,GA,GH,GM,GN,GQ,GW,IO,KE,KM,LR,LS,LY,MA,MG,ML,MR,MU,MW,MZ,NA,NE,NG,RE,RW,SC,SD,SH,SL,SN,SO,SS,ST,SZ,TD,TG,TN,TZ,UG,YT,ZA,ZM,ZW}'::text[] "country_codes"

union all

select
2 "id",
'Americas - Central and Southern',
'USD', 150, -- blockchain
'USD', 75, -- css_and_design
'USD', 105, -- dev_ops
'USD', 75, -- game_development
'USD', 135, -- javascript_and_frontend
'USD', 45, -- miscellaneous
'USD', 75, -- mobile_development
'USD', 90, -- web_development_and_backend
'{AR,BO,BR,BZ,CL,CO,CR,EC,FK,GF,GS,GT,GY,HN,MX,NI,PA,PE,PY,SR,SV,UY,VE}'::text[]

union all

select
3 "id",
'Americas - Northern',
'USD', 750, -- blockchain
'USD', 375, -- css_and_design
'USD', 525, -- dev_ops
'USD', 375, -- game_development
'USD', 675, -- javascript_and_frontend
'USD', 225, -- miscellaneous
'USD', 375, -- mobile_development
'USD', 450, -- web_development_and_backend
'{US,CA}'::text[] "country_codes"

union all

select
4 "id",
'Asia - Central and South-Eastern',
'USD', 225, -- blockchain
'USD', 113, -- css_and_design
'USD', 158, -- dev_ops
'USD', 113, -- game_development
'USD', 203, -- javascript_and_frontend
'USD', 68, -- miscellaneous
'USD', 113, -- mobile_development
'USD', 135, -- web_development_and_backend
'{BN,ID,KG,KH,KZ,LA,MM,MY,PH,SG,TH,TJ,TL,TM,UZ,VN}'::text[]

union all

select
5 "id",
'Asia - Eastern',
'USD', 225, -- blockchain
'USD', 113, -- css_and_design
'USD', 158, -- dev_ops
'USD', 113, -- game_development
'USD', 203, -- javascript_and_frontend
'USD', 68, -- miscellaneous
'USD', 113, -- mobile_development
'USD', 135, -- web_development_and_backend
'{CN,HK,JP,KP,KR,MN,MO,TW}'::text[]

union all

select
6 "id",
'Asia - Southern and Western',
'USD', 225, -- blockchain
'USD', 113, -- css_and_design
'USD', 158, -- dev_ops
'USD', 113, -- game_development
'USD', 203, -- javascript_and_frontend
'USD', 68, -- miscellaneous
'USD', 113, -- mobile_development
'USD', 135, -- web_development_and_backend
'{AE,AF,AM,AZ,BD,BH,BT,CY,GE,IL,IN,IQ,IR,JO,KW,LB,LK,MV,NP,OM,PK,PS,QA,SA,SY,TR,YE}'::text[]

union all

select
7 "id",
'Australia and New Zealand',
'USD', 750, -- blockchain
'USD', 375, -- css_and_design
'USD', 525, -- dev_ops
'USD', 375, -- game_development
'USD', 675, -- javascript_and_frontend
'USD', 225, -- miscellaneous
'USD', 375, -- mobile_development
'USD', 450, -- web_development_and_backend
'{AU,CC,CX,NF,NZ}'::text[]

union all

select
8 "id",
'Europe',
'USD', 675, -- blockchain
'USD', 338, -- css_and_design
'USD', 473, -- dev_ops
'USD', 338, -- game_development
'USD', 608, -- javascript_and_frontend
'USD', 203, -- miscellaneous
'USD', 338, -- mobile_development
'USD', 405, -- web_development_and_backend
'{AD,AL,AT,AX,BA,BE,CH,DE,DK,EE,ES,FI,FO,FR,GB,GG,GI,GR,HR,IE,IM,IS,IT,JE,LI,LT,LU,LV,MC,ME,MK,MT,NL,NO,PT,RS,SE,SI,SJ,SM,VA}'::text[]

union all

select
9 "id",
'Europe - Eastern',
'USD', 450, -- blockchain
'USD', 225, -- css_and_design
'USD', 315, -- dev_ops
'USD', 225, -- game_development
'USD', 405, -- javascript_and_frontend
'USD', 135, -- miscellaneous
'USD', 225, -- mobile_development
'USD', 270, -- web_development_and_backend
'{BG,BY,CZ,HU,MD,PL,RO,RU,SK,UA}'::text[]

union all

select
10,
'Other',
'USD', 75, -- blockchain
'USD', 38,  -- css and design
'USD', 53, -- dev ops
'USD', 38,  -- game development
'USD', 68, -- javascript
'USD', 23,  -- miscellaneous
'USD', 38,  -- mobile development
'USD', 45, -- web development
'{AG,AI,AS,AW,BB,BL,BM,BQ,BS,CK,CU,CW,DM,DO,FJ,FM,GD,GL,GP,GU,HT,JM,KI,KN,KY,LC,MF,MH,MP,MQ,MS,NC,NR,NU,PF,PG,PM,PN,PR,PW,SB,SX,TC,TK,TO,TT,TV,UM,VC,VG,VI,VU,WF,WS}'::text[]
