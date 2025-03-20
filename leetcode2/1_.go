// https://blog.stenyan.jp/entry/2023/09/17/194146

func containsDuplicate(nums []int) bool {
	slices.Sort(nums)
	uniqValues := slices.Compact(nums)
	return len(uniqValues) != len(nums)
}
