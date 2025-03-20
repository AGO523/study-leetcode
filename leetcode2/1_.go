func containsDuplicate(nums []int) bool {
	slices.Sort(nums)
	uniqValues := slices.Compact(nums)
	return len(uniqValues) != len(nums)
}
