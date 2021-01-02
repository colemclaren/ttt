VELKON GAMING TTT SERVER CODE
=========
From my past experiences, your gmod server's player slots __WILL__ become fulled or be filled up too quickly.

To fix this for garry, your requirements is MySQL server to launch __as many more totally__ new replicated gmod servers as we need effortlessly.

You absolutely __WILL__ see needs to expand your TTT server fleet right away if you're starting up with just one server.

What's Velkon Gaming TTT?
---
Velkon Gaming is the best Trouble in Terrorist Town base. Developed between 2015 to 2020, Cole McLaren also known as elu, has released their entire lifes work on their TTT server. His whole SERVER codebase to the most addicting TTT servers on Garry's Mod (over 30 servers) was made public for free, so that setting up your community is simplified and easy.

MySQL Server
---
Config located @ [system/cfg/sql/sv_config.lua](https://github.com/colemclaren/ttt/blob/master/addons/moat_addons/lua/system/cfg/sql/sv_config.lua#L3-L6).


Database Schema
---

Initial MySQL database setup @ [db.sql](https://github.com/colemclaren/ttt/blob/master/db.sql).

You can run these queries in your own table, or save the below code to a temporary SQL file, for example like \`moat.sql\`.

You must import these into your MySQL database to complete setup, before the inventories try to load on your server starting up.

Then import that temporary file to your MySQL \`forum\` database, subsequently creating the inventory data tables schema, which are absolutely necessary if you want to save data properly, like you should be doing between each of your players sessions on your server.

License TL;DR
---
You may use or reditribute Moat TTT freely, provided you do not take credit for it and include the license.

Pull Requests
---
Pull requests are welcome.

Please make sure your [line endings are correct](https://help.github.com/articles/dealing-with-line-endings/).

Also try to condense multiple commits down to easily see the changes made, either through [resetting the head](http://stackoverflow.com/a/5201642) or [rebasing the branch](http://stackoverflow.com/a/5189600).

Issues and Requests
---
These are also welcome.

Useful Info
---
[![https://www.discord.gg/elu](https://i.imgur.com/kz02DD6.gif)]
