"use client";

import { Dashboard } from "@/components/pages/dashboard";
import { useMeQuery } from "@/graphql/user";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

const Home = () => {
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
      <Dashboard onLogout={handleLogout} />
    </div>
  );
};

export default Home;
