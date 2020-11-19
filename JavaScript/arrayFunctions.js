async function asyncForEach(array, callback) {
  if (typeof callback !== "function") {
    throw new TypeError(callback + " is not a function");
  }
  for (let index = 0; index < array.length; index++) {
    await callback(array[index], index, array);
  }
}

async function asyncMap(array, callback) {
  if (typeof callback !== "function") {
    throw new TypeError(callback + " is not a function");
  }
  var result = [];
  for (let index = 0; index < array.length; index++) {
    var temp = await callback(array[index], index, array);
    result.push(temp);
  }
  return Promise.resolve(result);
}

async function asyncFilter(array, callback) {
  if (typeof callback !== "function") {
    throw new TypeError(callback + " is not a function");
  }
  var result = [];
  for (let index = 0; index < array.length; index++) {
    var temp = await callback(array[index], index, array);
    if (temp) {
      result.push(array[index]);
    }
  }
  return Promise.resolve(result);
}

async function asyncReduce(array, callback) {
  if (typeof callback !== "function") {
    throw new TypeError(callback + " is not a function");
  }
  var result;
  for (let index = 0; index < array.length; index++) {
    result = await callback(array[index], index, array);
  }
  return Promise.resolve(result);
}

// Incializacion de funciones
const unArray = [1, 2, 3];
const igualADos = (elem) => Promise.resolve(elem == 2);
const reducer = (accumulator, currentValue) =>
  Promise.resolve(accumulator + currentValue);
const print = (value) => Promise.resolve(console.log(value));
const porCinco = async (value) =>
  new Promise((resolve) => {
    setTimeout(() => resolve(value * 5), 100);
  });

// Pruebas
const init = async () => {
  try {
    // MAP
    console.log("Map");
    let result = await asyncMap([1, 2, 3], porCinco);
    console.log(result);
    // FILTER
    console.log("Filter");
    result = await asyncFilter([1, 2, 3], igualADos);
    console.log(result);
    // REDUCE
    console.log("Reduce");
    result = await asyncReduce([1, 2, 3, 4], reducer);
    console.log(result);
    // FOREACH
    console.log("forEach");
    result = await asyncForEach([1, -2, 3], print);
  } catch (error) {
    console.log(error);
    // handle error
  }
};

init();
