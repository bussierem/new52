package attack

type Attack interface {
	Roll() (int, bool, int)
	ToJSON() []byte
}
