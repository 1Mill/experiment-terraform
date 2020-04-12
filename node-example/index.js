const express = require('express');
const app = express();

app.get('/', (res, req) => {
	res.send('Hello world!');
});

app.listen(process.env.PORT, () => {
	console.log(`Listening on port ${process.env.PORT}`);
});
