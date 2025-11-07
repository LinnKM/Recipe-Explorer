Problem - 1
int countVowels(String str) {
  final vowels = ['a', 'e', 'i', 'o', 'u'];

  str = str.toLowerCase();
  List<String> strLst = str.split('');

  return strLst.where((element) => vowels.contains(element)).length;
}

Problem - 2
List<int> twoSum(List<int> nums, int target) {
  var num1;
  var num2;

  var filterNums = nums.where((num) => num < target).toList();
  print(filterNums);

  for (var firstNum in filterNums) {
    print(firstNum);
    for (var secondNum in filterNums) {
      print(secondNum);
      print('sum: ${firstNum + secondNum}');
      if (firstNum + secondNum == target) {
        num1 = firstNum;
        num2 = secondNum;
        break;
      }

      if (num1 != null && num2 != null) {
        break;
      }
    }
  }

  return (num2 == null && num1 == null)
      ? []
      : [nums.indexOf(num2), nums.indexOf(num1)];
}
