import { ApolloServer } from "@apollo/server";
import {
  ApolloGateway,
  IntrospectAndCompose,
  RemoteGraphQLDataSource,
} from "@apollo/gateway";
import { expressMiddleware } from "@apollo/server/express4";
import express from "express";
import http from "http";
import cors from "cors";
import { decryptToken } from "./utils";
import { SECRET } from "./config";

const app = express();
const httpServer = http.createServer(app);

const gateway = new ApolloGateway({
  supergraphSdl: new IntrospectAndCompose({
    subgraphs: [
      {
        name: "authentication",
        url: `${
          process.env.AUTHENTICATION_SERVICE_URL ||
          "http://service-authentication"
        }:4001/query`,
      },
      {
        name: "blogs",
        url: `${
          process.env.BLOG_SERVICE_URL || "http://service-blog"
        }:4002/query`,
      },
      {
        name: "users",
        url: `${
          process.env.USER_SERVICE_URL || "http://service-user"
        }:4003/query`,
      },
    ],
    pollIntervalInMs: 1000,
  }),
  buildService: ({ url }) => {
    return new RemoteGraphQLDataSource({
      url,
      willSendRequest({ request, context }) {
        if (context.authorization) {
          const token = context.authorization.split(" ")[1];
          const validatedUser = decryptToken(token, SECRET);
          if (validatedUser) {
            const { user_id: userID, role } = validatedUser;
            request.http?.headers.set("x-user-id", userID);
            request.http?.headers.set("x-role", role);
          }
        }
      },
    });
  },
});

const apolloServer = new ApolloServer({
  gateway,
  plugins: [],
});

async function startServer() {
  await apolloServer.start();

  app.use(
    "/",
    cors({
      origin: "http://localhost:3000",
      methods: "GET,HEAD,PUT,PATCH,POST,DELETE,OPTION",
      credentials: true,
    }),
    express.json(),
    expressMiddleware(apolloServer, {
      context: async ({ req }) => ({
        authorization: req.headers.authorization,
      }),
    })
  );

  await new Promise<void>((resolve) =>
    httpServer.listen({ port: process.env.GRAPHQL_PORT || 4000 }, resolve)
  );
  console.log(
    `🚀 Server ready at http://localhost:${
      process.env.GRAPHQL_PORT || 4000
    }/graphql`
  );
}

startServer().catch((err) => {
  console.error("Failed to start server", err);
});
