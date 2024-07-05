import { ApolloServer } from "@apollo/server";
import { ApolloGateway, IntrospectAndCompose } from "@apollo/gateway";
import { expressMiddleware } from "@apollo/server/express4";
import express from "express";
import http from "http";
import cors from "cors";

const app = express();
const httpServer = http.createServer(app);

const gateway = new ApolloGateway({
  supergraphSdl: new IntrospectAndCompose({
    subgraphs: [
      { name: "users", url: "http://service-user:4001/query" },
      { name: "contents", url: "http://service-content:4002/query" },
    ],
    pollIntervalInMs: 1000,
  }),
});

const apolloServer = new ApolloServer({
  gateway,
  plugins: [],
});

async function startServer() {
  await apolloServer.start();

  app.use(
    "/",
    cors<cors.CorsRequest>({ origin: ["*"] }),
    express.json(),
    expressMiddleware(apolloServer)
  );

  await new Promise<void>((resolve) =>
    httpServer.listen({ port: 4000 }, resolve)
  );
  console.log(`🚀 Server ready at http://localhost:4000/graphql`);
}

startServer().catch((err) => {
  console.error("Failed to start server", err);
});
