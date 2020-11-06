let state = {
    code: [1, 2, 3, '+', 4, '*'],
    pos: 0,
    stack: []
};

function evaluate(state) {
    const instruction = state.code[state.pos]; 
    if (state.stack.length >= 2) {
        const last = state.stack.pop();
        const secondLast = state.stack.pop();
        switch (instruction) {
            case '+':
                state.stack.push(secondLast + last);
                break;
            case '-':
                state.stack.push(secondLast - last);
                break;
            case '*':
                state.stack.push(secondLast * last);
                break;
            case '/':
                state.stack.push(secondLast / last);
                break;
            case '==':
                state.stack.push(secondLast == last);
                break;
            case '!=':
                state.stack.push(secondLast != last);
                break;
            case '<':
                state.stack.push(secondLast < last);
                break;
            case '<=':
                state.stack.push(secondLast <= last);
                break;
            case '>':
                state.stack.push(secondLast > last);
                break;
            case '>=':
                state.stack.push(secondLast >= last);
                break;
            case '!':
                state.stack.push(secondLast, !last);
                break;
            case '&&':
                state.stack.push(secondLast && last);
                break;
            case '||':
                state.stack.push(secondLast || last);
                break;
            default:
                const number = Number(instruction);
                if (number) {
                    state.stack.push(secondLast, last, number);
                } else {
                    console.log('Invalid instruction');
                }
                break;
        }
    } else if (state.stack.length === 1) {
        const last = state.stack.pop();
        if (instruction === '!') {
            state.stack.push(!last);
        } else {
            const number = Number(instruction);
            if (number) {
                state.stack.push(last, number);
            } else {
                console.log('Invalid instruction');
            }
        }
    } else {
        const number = Number(instruction);
        if (number) {
            state.stack.push(number);
        } else {
            console.log('Invalid instruction');
        }
    }
    state.pos++;
    return state;
}



console.log(evaluate(state));