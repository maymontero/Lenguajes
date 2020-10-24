class Exp
end

class Stmt
end

class Num < Exp
    def initialize(n)
        @n = Float(n)
    end
    def evaluate(state)
        @n
    end
end

class Var < Exp
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

class Sum < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) + @exp2.evaluate(state)
    end
end

class Mult < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) * @exp2.evaluate(state)
    end
end

class Minus < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) - @exp2.evaluate(state)
    end
end

class UMinus < Exp
    def initialize(exp)
        @exp = exp
    end
    def evaluate(state)
        @exp.evaluate(state) * -1
    end
end

class Div < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) / @exp2.evaluate(state)
    end
end

class ConstTrue < Exp
    def initialize()
        @value = true
    end
    def evaluate(state)
        @value
    end
end

class ConstFalse < Exp
    def initialize()
        @value = false
    end
    def evaluate(state)
        @value
    end
end

class CompEQ < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) == @exp2.evaluate(state)
    end
end

class CompLT < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) < @exp2.evaluate(state)
    end
end

class CompLTE < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) <= @exp2.evaluate(state)
    end
end

class CompGT < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) > @exp2.evaluate(state)
    end
end

class CompGTE < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) >= @exp2.evaluate(state)
    end
end

class CompDIF < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) != @exp2.evaluate(state)
    end
end

class OpNot < Exp
    def initialize(exp)
        @exp = exp
    end
    def evaluate(state)
        !@exp.evaluate(state)
    end
end

class OpAnd < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) && @exp2.evaluate(state)
    end
end

class OpOr < Exp
    def initialize(exp1, exp2)
        @exp1 = exp1
        @exp2 = exp2
    end
    def evaluate(state)
        @exp1.evaluate(state) || @exp2.evaluate(state)
    end
end

class Rand < Exp
    def initialize()
    end
    def evaluate(state)
        rand
    end
end

class Assign < Stmt
    def initialize(ref, exp)
        @ref = ref
        @exp = exp
    end
    def evaluate(state)
        state[@ref.id] = @exp.evaluate(state)
        state
    end
end

class Seq < Stmt
    def initialize(list)
        @list = list
    end 
    def evaluate(state)
        for stmt in @list
            stmt.evaluate(state)
        end
        state
    end
end

class IfThen < Stmt
    def initialize(cond, stmt)
        @cond = cond
        @stmt = stmt
    end
    def evaluate(state)
        @cond.evaluate(state) ? @stmt.evaluate(state) : state
    end
end

class IfThenElse < Stmt
    def initialize(cond, stmt1, stmt2)
        @cond = cond
        @stmt1 = stmt1
        @stmt2 = stmt2
    end
    def evaluate(state)
        @cond.evaluate(state) ? @stmt1.evaluate(state) : @stmt2.evaluate(state)
    end
end

class While < Stmt
    def initialize(cond, stmt)
        @cond = cond
        @stmt = stmt
    end
    def evaluate(state)
        while @cond.evaluate(state)
            @stmt.evaluate(state)
        end
        state
    end
end

class Print < Stmt
    def initialize(exp)
        @exp = exp
    end
    def evaluate(state)
        puts @exp.evaluate(state)
        state
    end
end