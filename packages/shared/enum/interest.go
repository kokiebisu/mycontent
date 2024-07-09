package enum

import "fmt"

type Interest string

const (
	InterestREACT      Interest = "REACT"
	InterestNODEJS     Interest = "NODEJS"
	InterestPYTHON     Interest = "PYTHON"
	InterestGO         Interest = "GO"
	InterestRUST       Interest = "RUST"
	InterestDOCKER     Interest = "DOCKER"
	InterestKUBERNETES Interest = "KUBERNETES"
)

func (i Interest) IsValid() bool {
	switch i {
	case InterestREACT, InterestNODEJS, InterestPYTHON, InterestGO, InterestRUST, InterestDOCKER, InterestKUBERNETES:
		return true
	}
	return false
}

func AllInterests() []Interest {
	return []Interest{
		InterestREACT,
		InterestNODEJS,
		InterestPYTHON,
		InterestGO,
		InterestRUST,
		InterestDOCKER,
		InterestKUBERNETES,
	}
}

func (Interest) Values() []string {
	return []string{
		InterestREACT.String(),
		InterestNODEJS.String(),
		InterestPYTHON.String(),
		InterestGO.String(),
		InterestRUST.String(),
		InterestDOCKER.String(),
		InterestKUBERNETES.String(),
	}
}

func (i Interest) String() string {
	return string(i)
}

func (i Interest) Validate() error {
	if !i.IsValid() {
		return fmt.Errorf("invalid interest: %s", i)
	}
	return nil
}