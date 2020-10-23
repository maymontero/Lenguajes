class Num
    def initialize(n)
        @n = Float(n)
    end
    def evaluate(state)
        @n
    end
end

class Var
    def initialize(id)
        @id = id
    end
    def evaluate(state)
        state[@id]
    end
    def id
        @id
    end
end

class Sum
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) + @exp2.evaluate(state)
    end
end

class Mult
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) * @exp2.evaluate(state)
    end
end

class Minus
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) - @exp2.evaluate(state)
    end
end

class UMinus
    def initialize(exp)
        @exp = exp
    end
    def evaluate(state)
        @exp.evaluate(state) * -1
    end
end

class Div
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) / @exp2.evaluate(state)
    end
end

class ConstTrue
    def initialize()
        @value = true
    end
    def evaluate(state)
        @value
    end
end

class ConstFalse
    def initialize()
        @value = false
    end
    def evaluate(state)
        @value
    end
end

class CompEQ
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) == @exp2.evaluate(state)
    end
end

class CompLT
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) < @exp2.evaluate(state)
    end
end

class CompLTE
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) <= @exp2.evaluate(state)
    end
end

class CompGT
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) > @exp2.evaluate(state)
    end
end

class CompGTE
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) >= @exp2.evaluate(state)
    end
end

class CompDIF
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) != @exp2.evaluate(state)
    end
end

class OpNot
    def initialize(exp)
        @exp = exp
    end
    def evaluate(state)
        !@exp.evaluate(state)
    end
end

class OpAnd
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) && @exp2.evaluate(state)
    end
end

class OpOr
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) || @exp2.evaluate(state)
    end
end

class Rand
    def initialize()
        @n = rand
    end
    def evaluate(state)
        @n
    end
end

class Assign
    def initialize(ref, exp)
        @ref = ref
        @exp = exp
    end
    def evaluate(state)
        state[@ref.id] = @exp.evaluate(state)
        state
    end
end

class Seq
    def initialize(first, second)
        @first = first
        @second = second
    end 
    def evaluate(state)
        @first.evaluate(state)
        @second.evaluate(state)
    end
end

class IfThen
    def initialize(cond, stmt)
        @cond = cond
        @stmt = stmt
    end
    def evaluate(state)
        @cond.evaluate(state) ? @stmt.evaluate(state) : nil
    end
end

class IfThenElse
    def initialize(cond, stmt1, stmt2)
        @cond = cond
        @stmt1 = stmt1
        @stmt2 = stmt2
    end
    def evaluate(state)
        @cond.evaluate(state) ? @stmt1.evaluate(state) : @stmt2.evaluate(state)
    end
end

class While
    def initialize(cond, stmt)
        @cond = cond
        @stmt = stmt
    end
    def evaluate(state)
        while @cond.evaluate(state)
            @stmt.evaluate(state)
        end
    end
end

class Print
    def initialize(stmt)
        @stmt = stmt
    end
    def evaluate(state)
        puts @stmt.evaluate(state)
    end
end