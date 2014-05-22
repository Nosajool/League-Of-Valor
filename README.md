# Vion Genesis in Ruby on Rails

I decided to attempt to recreate [*Vion Genesis*](http://ex5thgen.comyr.com) using [*Ruby on Rails*](http://rubyonrails.org)


**Old VGRPG +LOL**
Eons => Champions
* HP level int
* AD level int multiply by 1 and attacks once every turn
* AP level int multiply by 3 but attacks once every 3 turns
* Armor level int
* MR level int
* Melee/Ranged bool or string

Melee can hit opponents in positions 1 and 2 75/25
Ranged can hit any opponents 50/25/15/8/2

CC for supports? Or heal?
Hard CC/Soft CC?
**Champions Table, gives stats about each champion**
* Id int (by creation date) index
* Name string - be careful of special characters
* HP int
* AD int
* AP int
* Armor int
* MR int
* A support stat
* Role string Marksman/Mage/Support/Assasin/Fighter/Tank will limit the amount you can have in a team (max of 2 per role?)
* Exp (The experience you get from beating it) [EXP catagories?](http://bulbapedia.bulbagarden.net/wiki/Experience#Relation_to_level)
* Catch Rate (Make this somewhat dependant on the current IP costs with 6300's being very difficult to catch) [Variation of this](http://bulbapedia.bulbagarden.net/wiki/Catch_rate)
All of these stats will be adjusted depending on the meta
Sprites will be based on the champion id

**Champions List**
* ID (champion id)int index
* Champion Table id int (to pull the name, stats etc from)
* Type string ie. Shiny Tryndamere, Golden Teemo etc...
* Experience Points int
* Owner ID
* Lineup Slot
Debating whether or not to include the Champion Name, Level, and Owner's name. These can all be called or calculated through queries so I don't think we need them

**Items Table**
* ID
* Name
* Buy
Selling items will be a percent of the buy cost
Sprites will be based on the ID number

**Items List**
* ID
* Owner ID

**TODO:**
* Make usernames case insensitive. 
* Maybe store both a downcase version and the real version of the name. 
* You log in with username and password, it then compares your loginUsername.downcase with the username.downcase stored in the database. Don't really want to make users use email or id numbers
* Yeah, kind of a big nuissance right now