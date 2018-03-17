package attack

import (
	"battle-sim/systems"
	"encoding/json"
	"fmt"
	"strings"
)

type Magic struct {
	atk_type string `json:"atk_type"`
	hit      int    `json:"hit"`
	damage   string `json:"damage"`
	level    int    `json:"level"`
}

func (m_atk Magic) Roll() (map[string]int, map[string]int) {
	is_crit := 0
	roll_str := "1d20"
	if m_atk.hit >= 0 {
		roll_str += "+"
	}
	roll_str += fmt.Sprintf("%d", m_atk.hit)
	hit_result := dice.RollDice(roll_str)
	if hit_result["rolls"] == 20 {
		is_crit = 1
	}
	damage := dice.RollDice(m_atk.damage)
	if strings.Contains(m_atk.damage, "-") {
		damage = dice.RandFromRange(m_atk.damage)
	}
	hit_result["is_crit"] = is_crit
	return hit_result, damage
}

func (m_atk Magic) ToJSON() []byte {
	data, _ := json.Marshal(m_atk)
	return data
}
