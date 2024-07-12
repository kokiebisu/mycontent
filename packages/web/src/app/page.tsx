"use client";

import { useMeQuery } from "@/graphql/user";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

export default function Home() {
  const router = useRouter();
  const { data, loading, error, client } = useMeQuery();

  useEffect(() => {
    if (error) {
      router.push("/login");
    }
  }, [error, router]);

  const handleLogout = async () => {
    try {
      localStorage.removeItem("authToken");
      await client.clearStore();
      router.push("/login");
    } catch (err) {
      console.error(err);
    }
  };

  if (loading) return <div>Loading...</div>;

  if (!data?.me) return null;

  return (
    <div>
      <h1>Hello World {data?.me.email}</h1>
      <button onClick={handleLogout}>Logout</button>
    </div>
  );
}
