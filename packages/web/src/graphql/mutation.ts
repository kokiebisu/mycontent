import { gql } from "@apollo/client";

export const SIGNUP_MUTATION = gql`
  mutation CreateUser($input: CreateUserInput!) {
    createUser(input: $input) {
      id
      email
      password
      interest
      firstName
      lastName
      username
      yearsOfExperience
      publishTime
      createdAt
      updatedAt
    }
  }
`;
