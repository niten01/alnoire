class TransformError(Exception):
    def __init__(self, message):
        super().__init__(message)


class ParseError(Exception):
    def __init__(self, message):
        super().__init__(message)

class MergeError(Exception):
    def __init__(self, message):
        super().__init__(message)