package attack

import (
	"battle-sim/systems"
	"encoding/json"
	"fmt"
	"strings"
)

type Physical struct {
	atk_type string `json:"atk_type"`
	hit      int    `json:"hit"`
	damage   string `json:"damage"`
}

func (p_atk Physical) Roll() (map[string]int, map[string]int) {
	is_crit := 0
	roll_str := "1d20"
	if p_atk.hit >= 0 {
		roll_str += "+"
	}
	roll_str += fmt.Sprintf("%d", p_atk.hit)
	hit_result := dice.RollDice(roll_str)
	if hit_result["rolls"] == 20 {
		is_crit = 1
	}
	damage := dice.RollDice(p_atk.damage)
	if strings.Contains(p_atk.damage, "-") {
		damage = dice.RandFromRange(p_atk.damage)
	}
	hit_result["is_crit"] = is_crit
	return hit_result, damage
}

func (p_atk Physical) ToJSON() []byte {
	data, _ := json.Marshal(p_atk)
	return data
}
