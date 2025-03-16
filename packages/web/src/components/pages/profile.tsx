"use client";

import { useApolloClient } from "@apollo/client";
import { MeDocument, useUpdatePasswordMutation } from "@/graphql/user";
import { useEffect, useState } from "react";
import { ProfileTemplate } from "../templates/profile";

export const Profile = () => {
  const client = useApolloClient();
  const userData = client.readQuery({ query: MeDocument });
  // const [userData, setUserData] = useState<any>(null);
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

  const [updatePassword] = useUpdatePasswordMutation();

  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);

  // useEffect(() => {
  //   const fetchUserData = async () => {
  //     console.log('Fetching user data')
  //     const result = await client.query({ query: MeDocument });
  //     console.log('After read query:', result);
  //   }
  //   fetchUserData();
  // }, [client])

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

    console.log('USER DATA: ', userData)

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
    <ProfileTemplate
      userData={userData}
      errorMessage={errorMessage}
      successMessage={successMessage}
      handleUpdatePassword={handleUpdatePassword}
      setCurrentPassword={setCurrentPassword}
      setNewPassword={setNewPassword}
      setConfirmPassword={setConfirmPassword}
    />
  );
};
