const actors = require('comedy');
const restify = require('restify');
const restifyErrors = require('restify-errors');

class RestServerActor { ////////////////////////////////////////////////////////
  /** Actor initialization hook.
  */
  async initialize(selfActor) {
    this.log = selfActor.getLog();
    this.primeFinder = await selfActor.createChild(PrimeFinderActor);
    return this.initializeServer();
  }

  /** Initializes REST server.
   */
  async initializeServer() {
    const { log } = this;
    const server = restify.createServer({
      name: 'primes',
    });
    server.server.setTimeout(60000 * 10);
    server.get('/next-prime/:n', (req, res, next) => {
      log.info(`Handling next-prime request for number ${req.params.n}`);
      this.primeFinder.sendAndReceive('nextPrime', parseInt(req.params.n))
        .then(result => {
          log.info(`Handled next-prime request for number ${req.params.n}, result: ${result}`);
          res.header('Content-Type', 'text/plain');
          res.send(200, result.toString());
        })
        .catch(err => {
          log.error(`Failed to handle next-prime request for number ${req.params.n}`, err);
          next(new restifyErrors.InternalError(err));
        });
    });
    return new Promise((resolve, reject) => {
      server.listen(8080, () => {
        console.log('%s listening at %s', server.name, server.url);
        resolve(server);
      });
    });
  }
} // class RestServerActor

class PrimeFinderActor { ///////////////////////////////////////////////////////
  nextPrime(n) {
    if (isNaN(n) || n === Infinity || n === -Infinity) {
      throw new Error(`Illegal input ${n}!`);
    }
    const n0 = Math.floor(n + 1);
    if (this.isPrime(n0)) {
      return n0;
    }
    return this.nextPrime(n0);
  }

  isPrime(x) {
    for (let i = 2; i < x; i++) {
      if (x % i === 0) {
        return false;
      }
    }
    return true;
  }
} // class PrimeFinderActor

function run() {
  return actors({ root: RestServerActor });
}

if (require.main === module) {
  run();
} else {
  module.exports = {
    RestServerActor, PrimeFinderActor, run,
  };
}