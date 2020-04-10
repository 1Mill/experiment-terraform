'use strict'

exports.handler = (_event, _context, callback) => {
	const response = {
		body: '<p>Hello world!</p>',
		headers: { 'Content-Type': 'text/html; charset=utf-8' },
		statusCode: 200,
	};
	callback(null, response);
};
