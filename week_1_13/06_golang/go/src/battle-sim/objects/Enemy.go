package combatant

type Enemy struct {
	name    string `json:"name"`
	ctype   string `json:"type"`
	hp      int    `json:"health"`
	init    int    `json:"initiative"`
	defense int    `json:"defense"`
	attacks []Attack
}
