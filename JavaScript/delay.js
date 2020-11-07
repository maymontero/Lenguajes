const delay = (msecs) => {
    return new Promise((resolve) => (
        setTimeout(() => resolve(Date.now()), msecs)
    ));
};

const timeout = (msecs, prom) => {
    return Promise.race([
        prom,
        delay(msecs).then(() => {
            throw new Error('Timeout!');
        }),
    ]);
};