"use client";

import { useMeQuery } from "@/graphql/user";
import { useRouter } from "next/navigation";

export default function Home() {
  const router = useRouter();
  const { data, loading, error } = useMeQuery();

  if (loading) return <div>Loading...</div>;
  if (error) return router.push("/login");
  return <div>Hello World {data?.me.email}</div>;
}
