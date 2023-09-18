class Arithmetic_Sequence(object):
    def __init__(self, step: float, start_num: float):
        self.diff = step
        self.initial = start_num
    
    def term(self, n: int) -> float:
        return self.initial + ((n-1)*self.diff)
    
    def series(self, n: int) -> float:
        return (n/2)*(self.initial + self.term(n)), 4

class Geometric_Sequence(object):
    def __init__(self, ratio: float, start_num: float):
        self.ratio = ratio
        self.initial = start_num
    
    def term(self, n: int) -> float:
        return self.initial * pow(self.ratio, n-1)
    
    def series(self, n: int) -> float:
        return (self.initial*(pow(self.ratio, n) - 1))/(self.ratio - 1)

a = Arithmetic_Sequence(4, -1)
b = Geometric_Sequence(1/2, 3/4)
print(a.term(4), a.term(50), a.term(44))
print(a.series(50), a.series(100), a.series(1000))
print(b.term(5), b.term(50), b.term(100))
print(b.series(50), b.series(100), b.series(1000))