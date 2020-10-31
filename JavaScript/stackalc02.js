const state = {
    code: [1, 2, 3, '+', 4, '*'],
    pos: 0,
    stack: []
};

function evaluate(state) {
    const instruction = state.code[state.pos];
    const last = state.stack.pop();
    const secondLast = state.stack.pop();
    switch (instruction) {
        case '+':
            state.stack.push(secondLast + last)
            break;
        case '-':
            state.stack.push(secondLast - last)
            break;
        case '*':
            state.stack.push(secondLast * last)
            break;
        case '/':
            state.stack.push(secondLast / last)
            break;
        case '==':
            state.stack.push(secondLast == last)
            break;
        case '!=':
            state.stack.push(secondLast != last)
            break;
        case '<':
            state.stack.push(secondLast < last)
            break;
        case '<=':
            state.stack.push(secondLast <= last)
            break;
        case '>':
            state.stack.push(secondLast > last)
            break;
        case '>=':
            state.stack.push(secondLast >= last)
            break;
        case '!':
            state.stack.push(secondLast, !last)
            break;
        case '&&':
            state.stack.push(secondLast && last)
            break;
        case '||':
            state.stack.push(secondLast || last)
            break;
        default:
            const number = Number(instruction)
            if (number) {
                state.stack.push(secondLast, last, number)
            } else {
                console.log('Invalid instruction')
            }
            break;
    }
    return state;
}



console.log(evaluate(state));