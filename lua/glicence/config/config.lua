/*
GLicence Configuration
If you need help make a support ticket at http://www.livaco.tk/
*/


/*
NPC Config
*/

// Model of the NPC
GLicence.Config.Model = "models/odessa.mdl"

// ULX Groups that cannot access the NPC.
GLicence.Config.BlockedGroups = {"noaccess"}

// Cooldown for opening the NPC Menu.
GLicence.Config.Cooldown = 2 // seconds

// Color for the animation of the button.
GLicence.Config.ButtonAnimColor = Color(0, 0, 0, 200)


/*
Chat Config
*/

// Prefix
GLicence.Config.Prefix = "GLicence"

// Color of the prefix.
GLicence.Config.PrefixColor = Color(255, 0, 0)


/*
General Config
*/

// Price of the licence.
GLicence.Config.Cost = 150

// Whether to check if they already own a gun licence.
GLicence.Config.CheckForLicence = true


/*
bLogs Config
Only worry about this if you own bLogs (https://www.gmodstore.com/market/view/1599)
*/

// Log whenever someone attempts to access the menu without access.
GLicence.Config.LogNoAccess = true

// Log whenever someone attempts to access the menu during a cooldown.
GLicence.Config.LogCooldown = true

// Log whenever someone successsfuly buys a licence.
GLicence.Config.LogSucessfulBuy = true

// Log whenever someone tries to buy a gun licence but already has one.
GLicence.Config.LogAlreadyHas = true

// Log whether someone tries to buy a gun licence but cannot afford it.
GLicence.Config.LogCantAfford = true


// That was simple. Enjoy!
