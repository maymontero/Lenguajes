const fetch = require('node-fetch');

const BASE_URL = process.argv[2] || 'http://localhost:8080';
const VALUE = Math.max(+process.argv[3], 0) || 3e6;
const REQUEST_COUNT = Math.max(+process.argv[4], 0) || 1;

const nextPrimerURL = (n) => new URL(`next-prime/${+n}`, BASE_URL);

async function nextPrime(n, args) {
  const startTime = Date.now();
  const url = nextPrimerURL(n);
  const response = await fetch(url, { method: 'get', ...args });
  const result = await response.text();
  const time = (Date.now() - startTime) / 1000;
  return { n, result, time, url: `${url}` };
}

Promise.all(
  [...Array(REQUEST_COUNT).keys()]
    .map(() => nextPrime(VALUE)),
).then(
  console.log,
)
