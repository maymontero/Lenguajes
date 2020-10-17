class Num
    def initialize(n)
        @n = Float(n)
    end
end

class Var
end

class Sum
end

class Mult
end

class Minus
end

class UMinus
end

class Div
end

class ConstTrue
    def initialize()
        @value = true
    end
end

class ConstFalse
    def initialize()
        @value = false
    end
end

class OpNot
end

class OpAnd
end

class OpOr
end

class Rand
end

class Assign
end

class Seq
end

class IfThen
end

class IfThenElse
end

class While
end

class Print
end