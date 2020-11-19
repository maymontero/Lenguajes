const asyncMap = (array, func) => {
    return Promise.all(array.map(func));
};

const asyncFilter = (array, func) => {
    return asyncMap(array, async (item) => [item, await func(item)]).then((listArray) =>
        listArray.filter(([listItem, truthValue]) => truthValue).map(([listItem, truthValue]) => listItem)
    );
};

const asyncForEach = (array, func) => {
    return asyncMap(array, func).then()
};

const asyncReduce = async (array, func) => {
    return array.reduce(async (acum, item) => await func(acum, item));
};

asyncFilter([1, 2, 3], (n) => Promise.resolve(n % 2)).then(console.log);
asyncForEach([1, 2, 3], (n) => Promise.resolve(console.log(n)));