const http = require('http');

const server = http.createServer(function (request, response) {
    if (request.url === '/health') {
        response.writeHead(200, { 'Content-Type': 'application/json' });
        response.end(JSON.stringify({ status: 'ok' }));
    } else {
        response.writeHead(200, { "Content-Type": "text/html" });
        response.end("<html><body><center><h1>Hello DAS!</h1></center></body></html>");
    }
});

const port = process.env.PORT || 3000;
server.listen(port);

console.log(`Server running at http://localhost:${port}`);