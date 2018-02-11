package dice

import (
	"math/rand"
	"regexp"
	"strconv"
	"strings"
)

var regex, _ = regexp.Compile(`(?P<count>\d+)d(?P<dice>[\d]+)(?P<bonus>[+-]\d+)?`)

func RandInt(min, max int) int {
	diff := max - min
	randint := rand.Intn(diff) + min
	return randint
}

func RollDice(roll string) map[string]int {
	match := regex.FindStringSubmatch(roll)
	result := make(map[string]string)
	for i, name := range regex.SubexpNames() {
		if i != 0 && name != "" {
			result[name] = match[i]
		}
	}
	count, _ := strconv.Atoi(result["count"])
	dice, _ := strconv.Atoi(result["dice"])
	elem, ok := result["bonus"]
	bonus := 0
	if ok {
		bonus, _ = strconv.Atoi(elem)
	}
	rolls := 0
	for i := 0; i < count; i++ {
		rolls += RandInt(1, dice)
	}
	dice_result := map[string]int{
		"total": rolls + bonus,
		"rolls": rolls,
		"bonus": bonus,
	}
	return dice_result
}

func RandFromRange(dmg_str string) map[string]int {
	parts := strings.Split(dmg_str, "-")
	min, _ := strconv.Atoi(parts[0])
	max, _ := strconv.Atoi(parts[1])
	result := map[string]int{
		"total": RandInt(min, max),
	}
	return result
}
