"use client";

import Link from "next/link";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import {
  Card,
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
  CardFooter,
} from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { ArrowLeftIcon } from "./icon";
import { useApolloClient } from "@apollo/client";
import { MeDocument, useUpdatePasswordMutation } from "@/graphql/user";
import { useState } from "react";

const Profile = () => {
  const client = useApolloClient();
  const userData = client.readQuery({ query: MeDocument });
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

  const [updatePassword] = useUpdatePasswordMutation();

  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);

  const handleUpdatePassword = async (
    event: React.FormEvent<HTMLFormElement>
  ) => {
    event.preventDefault();
    setErrorMessage(null);
    setSuccessMessage(null);
    if (newPassword !== confirmPassword) {
      setErrorMessage("New password and confirm password do not match");
      return;
    }

    if (!userData?.me?.id) {
      setErrorMessage("User ID not found. Please try logging in again.");
      return;
    }

    try {
      const result = await updatePassword({
        variables: {
          id: userData.me.id,
          input: {
            currentPassword,
            newPassword,
          },
        },
      });

      if (result.data?.updatePassword) {
        setSuccessMessage("Password updated successfully");
        setCurrentPassword("");
        setNewPassword("");
        setConfirmPassword("");
      } else {
        setErrorMessage("Failed to update password. Please try again.");
      }
    } catch (error) {
      setErrorMessage(
        "Error updating password. Please check your current password and try again."
      );
      console.error("Error updating password:", error);
    }
  };

  return (
    <div className="w-full max-w-3xl mx-auto py-10 px-4 sm:px-6 lg:px-8">
      <div className="flex items-center space-x-4 mb-8">
        <Link
          href="/"
          className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground"
          prefetch={false}
        >
          <ArrowLeftIcon className="h-5 w-5" />
          <span>Back to Dashboard</span>
        </Link>
        <div className="ml-auto">
          <Avatar className="h-16 w-16">
            <AvatarImage src="/placeholder-user.jpg" />
            <AvatarFallback>JD</AvatarFallback>
          </Avatar>
        </div>
        <div>
          <h1 className="text-2xl font-bold">
            {userData?.me?.firstName} {userData?.me?.lastName}
          </h1>
          <p className="text-muted-foreground">{userData?.me?.email}</p>
        </div>
      </div>
      <div className="space-y-8">
        {errorMessage && (
          <div className="text-red-500 mb-4">{errorMessage}</div>
        )}
        {successMessage && (
          <div className="text-green-500 mb-4">{successMessage}</div>
        )}
        <Card>
          <CardHeader>
            <CardTitle>Change Password</CardTitle>
            <CardDescription>Update your account password</CardDescription>
          </CardHeader>
          <form onSubmit={handleUpdatePassword}>
            <CardContent className="space-y-4">
              <div className="grid gap-2">
                <Label htmlFor="current-password">Current Password</Label>
                <Input
                  id="current-password"
                  type="password"
                  onChange={(e) => setCurrentPassword(e.target.value)}
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="new-password">New Password</Label>
                <Input
                  id="new-password"
                  type="password"
                  onChange={(e) => setNewPassword(e.target.value)}
                />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="confirm-password">Confirm Password</Label>
                <Input
                  id="confirm-password"
                  type="password"
                  onChange={(e) => setConfirmPassword(e.target.value)}
                />
              </div>
            </CardContent>
            <CardFooter>
              <Button type="submit" className="ml-auto">
                Update Password
              </Button>
            </CardFooter>
          </form>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Integrations</CardTitle>
            <CardDescription>Manage your connected accounts</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-lg font-medium">Qiita</h3>
                <p className="text-muted-foreground">
                  Connect your Qiita account to share your posts.
                </p>
              </div>
              <Switch
                id="qiita-integration"
                defaultChecked
                aria-label="Qiita integration"
              />
            </div>
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-lg font-medium">Zenn</h3>
                <p className="text-muted-foreground">
                  Connect your Zenn account to share your articles.
                </p>
              </div>
              <Switch
                id="zenn-integration"
                defaultChecked={false}
                aria-label="Zenn integration"
              />
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default Profile;
