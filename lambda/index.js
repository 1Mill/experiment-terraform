'use strict'

exports.handler = (_event, _context, callback) => {
	const response = {
		// body: '<p>Hello world!</p>',
		body: '<p>Bonjour au monde!</p>',
		headers: { 'Content-Type': 'text/html; charset=utf-8' },
		statusCode: 200,
	};
	callback(null, response);
};
