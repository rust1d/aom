BLOODSPORT V4.0

SYNOPSIS:
Each player builds a team of up to 30 units to send into an arena for a fight to the death. Each round begins with a build period in which the players construct an army. At the end of the build, all units are transported to an arena and the fighting begins. The round continues until there is one team remaining. The winning players get a bonus for each solider remaining at the end of the battle. All teams are then awarded fresh resources to build an army for the next match and the process repeats. The game ends when a team has won 7 rounds.


GAME START:
Players start with 1200 food, 1500 wood, 1200 gold, 50 favor and all required buildings to reach Mythic age. A starting army of 5 soliders is provided to each player.


SCORING & RESOURCES:
After each battle, players are awarded food, wood, gold and favor to build an army for the next round. The amount increases each round based on the following formulas:

  * Food/Gold: 1200 + 50 * Round
  * Wood: (1200 + 50 * Round) * 1.25
  * Favor: 50 + 5 * Round

Each unit that survives the round awards the player 1 point of favor and a small amount of resources depending on the unit's original cost and current health at the end of the battle based on the following formula:

  * Food/Wood/Gold: kbUnitGetCurrentAICost() * 0.2

For example, a surviving Ulfsark with 100% health has an AI worth of 86 and will award 17 F/W/G and 1 point favor for surviving - that same Ulf damaged 50% would award 50% less resources.

During the battle period, players resources are set to 0 and returned at the start of the next build period.


AGING UP:
Players can age up to Classical at the start of the game, and for most Civs this is required to build viable military units. Heroic advancement becomes available in the 3rd round, Mythic is available in the 5th round, and Titan age is unrestricted.


GOD POWERS:
Players start the game with 1 Bolt god power and get an additional power with each age:

  * Classical: Restoration
  * Heroic: Flaming Weapons
  * Mythic: Lightning Storm
  * Titan: Lightning Storm

In addition, the following god powers are granted:

  * Every Age up: +1 Bolt
  * Every 6th round: +1 Bolt
  * Every 8th round: +1 Restoration


OPTIONS:
Set the map size to extend the game:

  * SMALL MAP: 7 Rounds
  * LARGE MAP: 11 Rounds
  * XL MAP: 14 Rounds

Set the game mode to:

  * SUPREMACY: Standard play as described above.
  * LIGHTNING: 45 second build period, research/build speeds at max. Standard Resources.
  * DEATHMATCH: 60 second build periods, resources reduced by 80%, all upgrades researched.


BALANCE:
All teams will always have the same number of units, regardless of the number of players on the team. When all teams are the same size, players are allowed 30 units each. When teams are not balanced, teams with more players get less units and resources based on the team to player ratios. This feature is dynamic and will automatically adjust the next round if a player resigns in the middle of the game.

For example, in a 3v2 game, the players on the team of 3 would get 20 units each and would receive 2/3 as much resources as the team of 2. The players on the team of 2 would get 30 units each and full resources.

The god powers award to each player are not affected by this ratio, so by default larger teams will still be somewhat stronger but also slower to age due to less resources.


MARKET:
This game relies heavily on resource management and a big part of that is using your market to sell and buy needed resources to maximize your units production and upgrades.


SCORE BOARD:
The number of units and hitpoints per team and player is displayed in the chat area and constantly refreshed. Only players with an active army are displayed.


ARENAS:
There are 7 battle arenas and each has a bonus associated with it.

  The Flats: Battle to win the relic at the center.
    * Possible relics are:
    * Anvil of Hephaestus - Armory technologies cost 10% less
    * Bow of Artemis - Archers cost 15% less, Trolls cost 15% less wood, Centaurs cost 20% less wood
    * Canopic Jar of Imsety - Infantry train 15% faster
    * Pandora's Box - Myth units train 25% faster
    * Wand of Gambantein - Temple technologies cost 20% less
    * Wedjat Eye - Myth units cost 10% less food, wood and gold

  The Spires: Control the spring at the center for restoration during battle.

  The Cliffs: Control the relic at the center for it's power during battle.
    * Possible relics are:
    * Mithril Horseshoes - Cavalry move 10% faster
    * Trios Bow - Archers have 2 more range and LOS
    * Toothed Arrows - Archers and Ballistas do 5% more damage
    * Hera's Thundercloud Shawl - All human soldiers have 5% less pierce damage vulnerability

  The Oasis: Control the mine at the center for a 40% speed boost (Journey GP).

  The Volcano: Control the relic at the center for it's power during battle.
    * Possible relics are:
    * Eye of Ornlu - Hypaspists, Axemen and Throwing Axemen have 5% more attack
    * Odin's Spear - Hoplites, Spearmen and Ulfsarks have 5% more attack
    * Girdle of Hippolyta - Toxotes, Chariot Archers and Throwing Axemen have 5% more HP
    * Tusk of the Iron Boar - Cavalry and Chariot Archers have 10% more HP
    * Armor of Achilles - Infantry have 5% less hack damage vulnerability

  The Forest: Control the berry bush at the center to earn +1 food per unit in area every tick.

  The Mythic: The Eclipse GP is active for all players. Control the relic at the center for it's power during battle.
    * Possible relics are:
    * Khopesh of Horus - Hero damage multiplier vs Myth units increased by 1
    * Boots of Kick Everything - Heroes move 20% faster
    * Tail of the Cerberus - Myth unit special attacks take 25% less time to recharge

With the exception of the healing spring, control of an arena item is determined by the total team count in the area, not the individual player count but control can switch between team members based on player counts.

STRATEGIES:
Players have LOS over the entire map. A smart player watches his opponents and builds counters to his units, and the smart team builds compliments to each other units.

Bolt is your Ace in the hole. Use it to turn the tide of a battle that would otherwise be lost. Use bolt to take out heavy hitting Heroes and Myth units, not slingers (unless taking out the slinger will win the round for you).

LIMITATIONS:
Econ Units, Flying Units and Garrisonable Siege (Helepolis, Seige Tower) are disabled. If you manage to build one, it will die immediately and you will be refunded some resources for them, albeit not the same exact resources. For example, building a villager costs 50 food but refunds the player 17 f/w/g. Use this resource exchange quirk as you see fit.

Loki's Hersir summon free units during battle. What can I say? Loki cheats. The free units are not included in a player's army and so are not used to determine the winner of a round. Surviving free Loki units are currently included in the Loki players next 30 unit army.

Favor accumulated during battle by Norse players is zeroed out at the end of each round and cannot be used to build resources.

Hades players Shades are deleted at the beginning of each match.

Set gets free animals for aging up - but a Pharaoh cannot summon more during battles.
