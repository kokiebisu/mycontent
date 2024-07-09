"use client";

import Link from "next/link";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectTrigger,
  SelectValue,
  SelectContent,
  SelectItem,
} from "@/components/ui/select";
import { Button } from "@/components/ui/button";
import { useMutation } from "@apollo/client";
import { SIGNUP_MUTATION } from "@/graphql/mutation";
import { useState } from "react";

function RegisterPage() {
  const [inputs, setInputs] = useState({
    email: "",
    firstName: "",
    interest: "",
    lastName: "",
    password: "",
    publishTime: "",
    username: "",
    yearsOfExperience: 0,
  });
  const [signup, { data, loading, error }] = useMutation(SIGNUP_MUTATION);

  const interests = [
    { value: "REACT", label: "React" },
    { value: "KUBERNETES", label: "Kubernetes" },
  ];

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const formattedInputs = {
        ...inputs,
        yearsOfExperience: parseInt(inputs.yearsOfExperience.toString(), 10),
        publishTime: inputs.publishTime.split(":")[0], // Extract only the hour
      };

      await signup({
        variables: {
          input: formattedInputs,
        },
      });
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <div className="flex min-h-dvh items-center justify-center bg-background px-4 py-12 sm:px-6 lg:px-8">
      <div className="w-full max-w-md space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-bold tracking-tight text-foreground">
            Sign up for an account
          </h2>
          <p className="mt-2 text-center text-sm text-muted-foreground">
            Or{" "}
            <Link
              href="#"
              className="font-medium text-primary hover:underline"
              prefetch={false}
            >
              log in to your existing account
            </Link>
          </p>
        </div>
        <form className="space-y-6" onSubmit={handleSubmit}>
          <div>
            <Label
              htmlFor="firstName"
              className="block text-sm font-medium text-muted-foreground"
            >
              First Name
            </Label>
            <div className="mt-1">
              <Input
                id="firstName"
                name="firstName"
                type="text"
                autoComplete="given-name"
                onChange={(e) =>
                  setInputs({ ...inputs, firstName: e.target.value })
                }
                required
                className="block w-full appearance-none rounded-md border border-input bg-background px-3 py-2 placeholder-muted-foreground shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary sm:text-sm"
              />
            </div>
          </div>
          <div>
            <Label
              htmlFor="lastName"
              className="block text-sm font-medium text-muted-foreground"
            >
              Last Name
            </Label>
            <div className="mt-1">
              <Input
                id="lastName"
                name="lastName"
                type="text"
                autoComplete="family-name"
                onChange={(e) =>
                  setInputs({ ...inputs, lastName: e.target.value })
                }
                required
                className="block w-full appearance-none rounded-md border border-input bg-background px-3 py-2 placeholder-muted-foreground shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary sm:text-sm"
              />
            </div>
          </div>
          <div>
            <Label
              htmlFor="email"
              className="block text-sm font-medium text-muted-foreground"
            >
              Email address
            </Label>
            <div className="mt-1">
              <Input
                id="email"
                name="email"
                type="email"
                autoComplete="email"
                onChange={(e) =>
                  setInputs({ ...inputs, email: e.target.value })
                }
                required
                className="block w-full appearance-none rounded-md border border-input bg-background px-3 py-2 placeholder-muted-foreground shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary sm:text-sm"
              />
            </div>
          </div>
          <div>
            <Label
              htmlFor="username"
              className="block text-sm font-medium text-muted-foreground"
            >
              Username
            </Label>
            <div className="mt-1">
              <Input
                id="username"
                name="username"
                type="text"
                autoComplete="username"
                onChange={(e) =>
                  setInputs({ ...inputs, username: e.target.value })
                }
                required
                className="block w-full appearance-none rounded-md border border-input bg-background px-3 py-2 placeholder-muted-foreground shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary sm:text-sm"
              />
            </div>
          </div>
          <div>
            <Label
              htmlFor="password"
              className="block text-sm font-medium text-muted-foreground"
            >
              Password
            </Label>
            <div className="mt-1">
              <Input
                id="password"
                name="password"
                type="password"
                autoComplete="current-password"
                required
                onChange={(e) =>
                  setInputs({ ...inputs, password: e.target.value })
                }
                className="block w-full appearance-none rounded-md border border-input bg-background px-3 py-2 placeholder-muted-foreground shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary sm:text-sm"
              />
            </div>
          </div>
          <div>
            <Label
              htmlFor="interest"
              className="block text-sm font-medium text-muted-foreground"
            >
              Interest
            </Label>
            <div className="mt-1">
              <Select
                id="interest"
                name="interest"
                required
                onValueChange={(value) =>
                  setInputs({ ...inputs, interest: value })
                }
              >
                <SelectTrigger>
                  <SelectValue placeholder="Select your interest" />
                </SelectTrigger>
                <SelectContent>
                  {interests.map((interest) => (
                    <SelectItem key={interest.value} value={interest.value}>
                      {interest.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>
          <div>
            <Label
              htmlFor="yearsOfExperience"
              className="block text-sm font-medium text-muted-foreground"
            >
              Years of Experience
            </Label>
            <div className="mt-1">
              <Input
                id="yearsOfExperience"
                name="yearsOfExperience"
                type="number"
                min="0"
                required
                onChange={(e) =>
                  setInputs({
                    ...inputs,
                    yearsOfExperience: parseInt(e.target.value, 10),
                  })
                }
                className="block w-full appearance-none rounded-md border border-input bg-background px-3 py-2 placeholder-muted-foreground shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary sm:text-sm"
              />
            </div>
          </div>
          <div>
            <Label
              htmlFor="publishTime"
              className="block text-sm font-medium text-muted-foreground"
            >
              Publish Time (Hour)
            </Label>
            <div className="mt-1">
              <Input
                id="publishTime"
                name="publishTime"
                type="time"
                required
                onChange={(e) =>
                  setInputs({ ...inputs, publishTime: e.target.value })
                }
                className="block w-full appearance-none rounded-md border border-input bg-background px-3 py-2 placeholder-muted-foreground shadow-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary sm:text-sm"
              />
            </div>
          </div>
          {error && (
            <div className="text-red-500 text-sm">
              {error.message || "An error occurred during signup."}
            </div>
          )}
          {data && (
            <div className="text-green-500 text-sm">
              Signup successful! You can now log in.
            </div>
          )}
          <div>
            <Button
              type="submit"
              disabled={loading}
              className="flex w-full justify-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-primary-foreground shadow-sm hover:bg-primary/90 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-primary focus-visible:ring-offset-1"
            >
              {loading ? "Signing up..." : "Sign up"}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default RegisterPage;
