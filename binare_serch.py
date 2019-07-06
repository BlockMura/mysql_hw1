from random import randint

a = []
for i in range(15):
    a.append(randint(1, 50))
a.sort()
print(a)

# искомое число
value = int(input())



mid = len(a) // 2
low = 0
high = len(a) - 1

while a[mid] != value and low <= high:
    if value > a[mid]:
        low = mid + 1
    else:
        high = mid - 1
    mid = (low + high) // 2

if low > high:
    print("No value")
else:
    print("ID =", mid)




def binarySearch(alist, item):
    first = 0
    last = len(alist)-1
    found = False

    while first<=last and not found:
        midpoint = (first + last)//2
        if alist[midpoint] == item:
            found = True
	    else:
	        if item < alist[midpoint]:
	            last = midpoint-1
	        else:
	            first = midpoint+1

    return found

testlist = [0, 1, 2, 8, 13, 17, 19, 32, 42,]
print(binarySearch(testlist, 3))
print(binarySearch(testlist, 13))
