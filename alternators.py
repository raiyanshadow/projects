# Static Alternator
class Alternator(object):
    def __init__(self, def_val: bool = True):
        self.val = def_val # default value = True, alternate value = False

    def next(self):
        self.val = not self.val

# Dynamic Alternator
class List_Alternator(object):
    def __init__(self, arr: list, start_idx: int = 0):
        if start_idx > len(arr) - 1:
            raise ValueError("Index out of bounds")
        self.arr = arr
        self.start = start_idx
    
    @property
    def val(self) -> any:
        return self.arr[self.idx]
    
    @property
    def size(self) -> int:
        return len(self.arr)
        
    @property
    def idx(self) -> int:
        a = self.start % self.size
        self._start = a
        return a
    
    def next(self):
        self.start = (self.start+1) % self.size

a = List_Alternator([True, False, 'Maybe', 'Sure'])
for i in range(10):
    print(a.val)
    a.next()