"use client";

import {
  ApolloClient,
  ApolloLink,
  ApolloProvider,
  HttpLink,
  InMemoryCache,
  concat,
} from "@apollo/client";

const httpLink = new HttpLink({
  uri:
    "http://external-alb-1612178360.us-east-1.elb.amazonaws.com/graphql" ||
    "http://localhost:4000/graphql",
});

const authMiddleware = new ApolloLink((operation, forward) => {
  const token = localStorage.getItem("authToken");
  operation.setContext({
    headers: {
      authorization: token ? `Bearer ${token}` : "",
    },
  });
  return forward(operation);
});

const client = new ApolloClient({
  link: concat(authMiddleware, httpLink),
  cache: new InMemoryCache(),
});

const ApolloWrapper = ({ children }: { children: React.ReactNode }) => (
  <ApolloProvider client={client}>{children}</ApolloProvider>
);

export default ApolloWrapper;
