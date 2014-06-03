# About Project
League of Legends themed rpg.

# Play Style
* Navigate around the site to find champions
* Build your team using 5 champions
* Battle other summoners to increase the levels of your champions
* Use the spirits of pro players, buffs and items to give your team an edge in close matches
* Climb various leaderboards

# Database Tables

## Champion Table (TableChampion)
<table>
	<tr>
		<th>Column Name</th>
		<th>Description</th>
		<th>Variable Type</th>
		<th>Unique?</th>
	</tr>
	<tr>
		<td>id</td>
		<td>Champion's id number. Champion with the earliest release date is #1</td>
		<td>int</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>health</td>
		<td>Champion's health</td>
		<td>int</td>
		<td>No</td>
	</tr>
	<tr>
		<td>attack_damage</td>
		<td>Champion's base attack damage stat</td>
		<td>int</td>
		<td>No</td>
	</tr>
	<tr>
		<td>ability_power</td>
		<td>Champion's base ability power stat</td>
		<td>int</td>
		<td>No</td>
	</tr>
	<tr>
		<td>armor</td>
		<td>Champion's base armor stat</td>
		<td>int</td>
		<td>No</td>
	</tr>
	<tr>
		<td>magic_resist</td>
		<td>Champion's base magic resist stat</td>
		<td>int</td>
		<td>No</td>
	</tr>
	<tr>
		<td>armor</td>
		<td>Champion's base armor stat</td>
		<td>int</td>
		<td>No</td>
	</tr>
	<tr>
		<td>role</td>
		<td>The champion's role in the team. No more than 2 of each role per team. Possible roles: Marksman, Mage, Support, Assasin, Fighter, Tank</td>
		<td>string</td>
		<td>No</td>
	</tr>
	<tr>
		<td>catch_rate</td>
		<td>Determines how difficult the champion is to catch. Not entirely sure how this mechanic will work</td>
		<td>int</td>
		<td>No</td>
	</tr>
	<tr>
		<td>range</td>
		<td>Determines how many targets the champion can hit from their current position. Between 1-10</td>
		<td>int</td>
		<td>No</td>
	</tr>
</table>

* A support stat (crowd control? %chance of disabling enemy attack?)
* role string Marksman/Mage/Support/Assasin/Fighter/Tank will limit the amount you can have in a team (max of 2 per role?)
* catch_rate int (Make this somewhat dependant on the current IP costs with 6300's being very difficult to catch) [Variation of this](http://bulbapedia.bulbagarden.net/wiki/Catch_rate)
All of these stats will be adjusted depending on the meta
Sprites will be based on the champion id
experience will be generated by the champion's level

## Champions List (Champion)
<table>
	<tr>
		<th>Column Name</th>
		<th>Description</th>
		<th>Variable Type</th>
		<th>Association</th>
		<th>Unique?</th>
	</tr>
	<tr>
		<td>id</td>
		<td>i-th champion created</td>
		<td>int</td>
		<td>None</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>table_champion_id</td>
		<td>Corresponds to which champion from the Table Champions</td>
		<td>int</td>
		<td>Yes, has_one table champion</td>
		<td>No</td>
	</tr>
	<tr>
		<td>experience</td>
		<td>How much experience the champion has</td>
		<td>int</td>
		<td>None</td>
		<td>No</td>
	</tr>
	<tr>
		<td>level</td>
		<td>The champion's level. Modified at the end of every battle based on experience</td>
		<td>int</td>
		<td>None</td>
		<td></td>
	</tr>
	<tr>
		<td>user_id</td>
		<td>Which user currently owns the champion?</td>
		<td>int</td>
		<td>Yes, belongs_to user</td>
		<td>No</td>
	</tr>
	<tr>
		<td>position</td>
		<td>What position the champion is in. (1 is front line, 5 is back line). 0 is not in starting roster</td>
		<td>int</td>
		<td>None</td>
		<td>No</td>
	</tr>
	<tr>
		<td>skin</td>
		<td>Code that tells you what skins your champion has unlocked. Default is 1000000000 See below</td>
		<td>int</td>
		<td>None</td>
		<td>No</td>
	</tr>
	<tr>
		<td>active_skin</td>
		<td>Which skin you have active. The default would be skin 0.</td>
		<td>int</td>
		<td>None</td>
		<td>No</td>
	</tr>
</table>

[associations](http://guides.rubyonrails.org/association_basics.html)
Note: 3.1 Controlling Caching might be important for battles 
To determine whether or not you have a skin, will store a 10 digit integer. The default value will be 1000000000 denoting skins #0-9. In order to determine if you have skin #x, call (@list_champion.skins.to_s[x] == 1)? To add the skin to the code, @list_champion.skins += 10**(9-x)
Will need a system and a skins table to determine the stat boots

* users has_many :table_champions, through: :list_champions
* table_champion :has_many users, through: :list_champions

* list_champion belongs_to :users
* users has_many :list_champions

* list_champion has_one :table_champion
* table_champion has_many :list_champions



**Pros Table**
* id int
* proname
* Team
* AD
* AP
* Armor
* Magic Resist
* Support stat
* table_champion_id: int
The pros will be somewhat the equivalent of items in vion genesis. Where you can equipt spirit of HotshotGG to nidalee
All of these statistic boosts will be % increases to the stats
Each pro has a single champion. Pros can share the same champion. This is why different stat boosts will actually be different




**Items Table**
* ID
* Name
* Buy
Selling items will be a percent of the buy cost
Sprites will be based on the ID number
Not sure what items will be used for. Maybe equipt them as well to add flat increases to base stats wheras pros and buffs are %increases

**Items List**
* ID
* Owner ID

**Buffs**
Obviously, there has to be red, blue, baron. A team can only have 1 of them. If you defeat someone, you take their buff.
There will be:
* 1xbaron buff
* 2xblue buffs
* 2xred buffs
These have to be pretty big boosts to your stats

**Battle**
* 5 vs 5
* Organize Roster - Champions at the front are more likely to get hit than champions at the back
* Champion Range tells you which champions you can hit
* You attack with your attack damage vs 1 random opponent's armor (weighted based on position)
* You attack with your ability power once every 3 turnsin addition to your regular attack
* Not sure what the order of attacking is
* All stats are calculated at the beginning of battle. (Levelling up occurs after battle)

**Range**
<table>
	<tr>
		<th> </th>
		<th colspan="5">Probability of hitting target x (%)</th>
	</tr>
	<tr>
		<th># of targets you can hit</th>
		<th>1</th>
		<th>2</th>
		<th>3</th>
		<th>4</th>
		<th>5</th>
	</tr>
	<tr>
		<td>1</td>
		<td>100</td>
		<td>---</td>
		<td>---</td>
		<td>---</td>
		<td>---</td>
	</tr>
	<tr>
		<td>2</td>
		<td>70</td>
		<td>30</td>
		<td>---</td>
		<td>---</td>
		<td>---</td>
	</tr>
	<tr>
		<td>3</td>
		<td>55</td>
		<td>35</td>
		<td>15</td>
		<td>---</td>
		<td>---</td>
	</tr>
	<tr>
		<td>4</td>
		<td>50</td>
		<td>20</td>
		<td>10</td>
		<td>5</td>
		<td>---</td>
	</tr>
	<tr>
		<td>5</td>
		<td>50</td>
		<td>25</td>
		<td>15</td>
		<td>8</td>
		<td>2</td>
	</tr>
</table>

**TODO:**
* champion list
* Search by ID or search by username using routes