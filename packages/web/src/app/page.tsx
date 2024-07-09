"use client";

import "./globals.css";
import { SignUp } from "@/components/sign-up";
import { gql, useQuery } from "@apollo/client";

const HEALTH_DATA = gql`
  query Query {
    health
  }
`;

export default function Home() {
  return (
    <div>
      <SignUp />
    </div>
  );
}
