export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
export type MakeEmpty<T extends { [key: string]: unknown }, K extends keyof T> = { [_ in K]?: never };
export type Incremental<T> = T | { [P in keyof T]?: P extends ' $fragmentName' | '__typename' ? T[P] : never };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: { input: string; output: string; }
  String: { input: string; output: string; }
  Boolean: { input: boolean; output: boolean; }
  Int: { input: number; output: number; }
  Float: { input: number; output: number; }
};

export type AuthPayload = {
  __typename?: 'AuthPayload';
  authToken: Scalars['String']['output'];
  userId: Scalars['String']['output'];
};

export type Blog = {
  __typename?: 'Blog';
  content: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  title: Scalars['String']['output'];
  updatedAt: Scalars['String']['output'];
  userId: Scalars['ID']['output'];
};

export type Integration = {
  __typename?: 'Integration';
  apiKey: Scalars['String']['output'];
  createdAt: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  platform: Platform;
  updatedAt: Scalars['String']['output'];
  userId: Scalars['ID']['output'];
};

export enum Interest {
  Docker = 'DOCKER',
  Go = 'GO',
  Kubernetes = 'KUBERNETES',
  Nodejs = 'NODEJS',
  Python = 'PYTHON',
  React = 'REACT',
  Rust = 'RUST'
}

export type LoginInput = {
  email: Scalars['String']['input'];
  password: Scalars['String']['input'];
};

export type LogoutPayload = {
  __typename?: 'LogoutPayload';
  message: Scalars['String']['output'];
};

export type Mutation = {
  __typename?: 'Mutation';
  deleteBlog: Scalars['String']['output'];
  deleteIntegration: Scalars['String']['output'];
  login?: Maybe<AuthPayload>;
  logout?: Maybe<LogoutPayload>;
  register?: Maybe<AuthPayload>;
  updateUser: User;
};


export type MutationDeleteBlogArgs = {
  id: Scalars['ID']['input'];
};


export type MutationDeleteIntegrationArgs = {
  id: Scalars['ID']['input'];
};


export type MutationLoginArgs = {
  input?: InputMaybe<LoginInput>;
};


export type MutationRegisterArgs = {
  input?: InputMaybe<RegisterInput>;
};


export type MutationUpdateUserArgs = {
  id: Scalars['ID']['input'];
  input?: InputMaybe<UpdateUserInput>;
};

export enum Platform {
  Medium = 'MEDIUM',
  Qiita = 'QIITA',
  Zenn = 'ZENN'
}

export type Query = {
  __typename?: 'Query';
  blog: Blog;
  blogs: Array<Blog>;
  blogsByUserId: Array<Blog>;
  integration: Integration;
  integrationsByUserId: Array<Integration>;
  user: User;
  users: Array<User>;
};


export type QueryBlogArgs = {
  id: Scalars['ID']['input'];
};


export type QueryBlogsByUserIdArgs = {
  userId: Scalars['ID']['input'];
};


export type QueryIntegrationArgs = {
  id: Scalars['ID']['input'];
};


export type QueryIntegrationsByUserIdArgs = {
  platform: Platform;
  userId: Scalars['ID']['input'];
};


export type QueryUserArgs = {
  id: Scalars['ID']['input'];
};

export type RegisterInput = {
  email: Scalars['String']['input'];
  firstName: Scalars['String']['input'];
  interest: Interest;
  lastName: Scalars['String']['input'];
  password: Scalars['String']['input'];
  publishTime: Scalars['String']['input'];
  username: Scalars['String']['input'];
  yearsOfExperience: Scalars['Int']['input'];
};

export type UpdateUserInput = {
  email: Scalars['String']['input'];
  firstName: Scalars['String']['input'];
  interest: Interest;
  lastName: Scalars['String']['input'];
  password: Scalars['String']['input'];
  publishTime: Scalars['String']['input'];
  username: Scalars['String']['input'];
  yearsOfExperience: Scalars['Int']['input'];
};

export type User = {
  __typename?: 'User';
  createdAt: Scalars['String']['output'];
  email: Scalars['String']['output'];
  firstName: Scalars['String']['output'];
  id: Scalars['ID']['output'];
  interest: Interest;
  lastName: Scalars['String']['output'];
  password: Scalars['String']['output'];
  publishTime: Scalars['String']['output'];
  updatedAt: Scalars['String']['output'];
  username: Scalars['String']['output'];
  yearsOfExperience: Scalars['Int']['output'];
};
