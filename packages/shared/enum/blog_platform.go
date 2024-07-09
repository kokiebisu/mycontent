package enum

import "fmt"

type Platform string

const (
	PlatformZenn   Platform = "ZENN"
	PlatformQiita  Platform = "QIITA"
	PlatformMedium Platform = "MEDIUM"
)

func (i Platform) IsValid() bool {
	switch i {
	case PlatformZenn, PlatformQiita, PlatformMedium:
		return true
	}
	return false
}

func AllPlatforms() []Platform {
	return []Platform{
		PlatformZenn,
		PlatformQiita,
		PlatformMedium,
	}
}

func (Platform) Values() []string {
	return []string{
		PlatformZenn.String(),
		PlatformQiita.String(),
		PlatformMedium.String(),
	}
}

func (p Platform) String() string {
	return string(p)
}

func (p Platform) Validate() error {
	if !p.IsValid() {
		return fmt.Errorf("invalid interest: %s", p)
	}
	return nil
}
