select 1 id, 'Blockchain' "name", 'blockchain_ecpm_cents' ecpm_column_name, '{Blockchain,Cryptography}'::text[] keywords
union all
select 2, 'CSS & Design', 'css_and_design_ecpm_cents', '{"CSS & Design"}'
union all
select 3, 'DevOps', 'dev_ops_ecpm_cents', '{DevOps,Python,Ruby,Security,Serverless}'
union all
select 4, 'Game Development', 'game_development_ecpm_cents', '{"Game Development","Virtual Reality"}'
union all
select 5, 'JavaScript & Frontend', 'javascript_and_frontend_ecpm_cents', '{Angular,Dart,Frontend,JavaScript,React,VueJS}'
union all
select 6, 'Miscellaneous', 'miscellaneous_ecpm_cents', '{C,D,"Developer Resources",Erlang,F#,Haskell,IoT,Julia,"Machine Learning",Other,Python,Q,R,Rust,Scala}'
union all
select 7, 'Mobile Development', 'mobile_development_ecpm_cents', '{Android,"Hybrid & Mobile Web",Kotlin,Objective-C,Swift,iOS}'
union all
select 8, 'Web Development & Backend', 'web_development_and_backend_ecpm_cents', '{.NET,Backend,Database,Go,Groovy,Java,PHP,PL/SQL,Python,Ruby}'
