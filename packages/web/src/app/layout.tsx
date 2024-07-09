import "./globals.css";
import ApolloWrapper from "@/lib/apollo";

export default function Layout({ children }) {
  return (
    <html lang="en">
      <ApolloWrapper>
        <body>{children}</body>
      </ApolloWrapper>
    </html>
  );
}
