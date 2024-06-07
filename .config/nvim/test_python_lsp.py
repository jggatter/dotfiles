from pprint import pprint

STOP = 'hellloo'

class SomeClass:
    """Hello."""
    def __init__(self):
        self.hello = 'stop'
        self.__hello = STOP


    def pass_args(self, greeting: str) -> int:
        return 4

def main():
    print(f'hello world')
    x: int = 0
    some_class = SomeClass()
    pprint(some_class.hello + ' mocking me')
    some_class.pass_args(5)
    del some_class

    return str(5 + 21)
