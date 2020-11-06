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


let state = {
    code: [ 3, 4, 1, '+', '>' ],
    pos: 0,
    stack: []
};

for(let i = 0; i < state.code.length-1; i++){
    evaluate(state);
}

console.log(evaluate(state));

console.log("-----------------------------------------------------------------")
state.code = [ 22, 33, 4, '-', '*' ];
state.pos = 0; 

for(let i = 0; i < state.code.length-1; i++){
    evaluate(state);
}
console.log(evaluate(state));

