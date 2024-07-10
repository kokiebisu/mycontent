package utils

import "time"

func ParseTime(timeStr string) (time.Time, error) {
	var parsedTime time.Time
	var err error
	formats := []string{"15:04", "15", "3:04PM", "3PM"}
	for _, format := range formats {
		parsedTime, err = time.Parse(format, timeStr)
		if err == nil {
			break
		}
	}
	return parsedTime, err
}
