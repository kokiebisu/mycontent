"use client";

import { useMeQuery } from "@/graphql/user";
import { useRouter } from "next/navigation";

export default function Home() {
  const router = useRouter();
  const { data, loading, error, client } = useMeQuery();

  const handleLogout = async () => {
    try {
      localStorage.removeItem("authToken");
      await client.resetStore();
      router.push("/login");
    } catch (err) {
      console.error(err);
    }
  };

  if (loading) return <div>Loading...</div>;
  if (error) return router.push("/login");
  return (
    <div>
      <h1>Hello World {data?.me.email}</h1>
      <button onClick={handleLogout}>Logout</button>
    </div>
  );
}
