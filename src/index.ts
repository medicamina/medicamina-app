import { join } from 'path';
import { app } from './api';
import { CONFIG } from './secure/config';
import { static as expressStatic } from 'express';
import { createServer } from 'http';

app.use(expressStatic(join(__dirname + 'public')));

const server: CoreableServer = createServer(app) as CoreableServer;

server.listen(CONFIG.port, () => {
	console.log("\n", "\x1b[31m", `http://localhost:${CONFIG.port}/graphql`, "\x1b[37m", "\n");
});