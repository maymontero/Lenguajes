const asyncMap = (xs, f) => {
    return Promise.all(xs.map(f));
};

const asyncForEach = async (xs, f) => {
    // Se usa la misma función map pero sin un retorno del nuevo array.
    await asyncMap(xs, f);
};

const asyncFilter = (xs, f) => {
    // Se forma una lista [(x, fx)]
    return Promise.all(xs.map(async (x) => [x, await f(x)])).then((ys) =>
        // Descartamos los valores de patrón (x, false)
        ys.filter(([, b]) => b).map(([v]) => v)
    );
};

const asyncReduce = async (xs, f, v) => {
    return xs.reduce(async (acc, x) => f(await acc, x), v);
};

asyncReduce([1, 2, 3], async (a, b) => a + b, 0).then(console.log);
asyncMap([1, 2, 3], (v) => Promise.resolve(v + 1)).then(console.log);
asyncFilter([1, 2, 3], (v) => Promise.resolve(v % 2 === 0)).then(console.log);

/* 
const run = async () => {
    console.log("Start");
    foodArray.forEach(async (food) => {
      const output = await AIFoodRecognition(food);
      console.log(output);
    });
    console.log("End");
  };
async function asyncForEach(array, callback) {
    for (let index = 0; index < array.length; index++) {
      await callback(array[index], index, array);
    }
  }
asyncForEach([1, 2, 3], async (num) => {
    await waitFor(50);
    console.log(num);
  }) */