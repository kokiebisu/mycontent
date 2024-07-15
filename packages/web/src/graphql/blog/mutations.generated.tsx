import * as Types from '../types';

import { gql } from '@apollo/client';
import * as Apollo from '@apollo/client';
const defaultOptions = {} as const;
export type DeleteBlogMutationVariables = Types.Exact<{
  id: Types.Scalars['ID']['input'];
}>;


export type DeleteBlogMutation = { __typename?: 'Mutation', deleteBlog: string };

export type DeleteIntegrationMutationVariables = Types.Exact<{
  id: Types.Scalars['ID']['input'];
}>;


export type DeleteIntegrationMutation = { __typename?: 'Mutation', deleteIntegration: string };

export type CreatePresignedUrlMutationVariables = Types.Exact<{
  input: Types.CreatePresignedUrlInput;
}>;


export type CreatePresignedUrlMutation = { __typename?: 'Mutation', createPresignedUrl: { __typename?: 'PresignedUrlResponse', url: string, key: string } };


export const DeleteBlogDocument = gql`
    mutation DeleteBlog($id: ID!) {
  deleteBlog(id: $id)
}
    `;
export type DeleteBlogMutationFn = Apollo.MutationFunction<DeleteBlogMutation, DeleteBlogMutationVariables>;

/**
 * __useDeleteBlogMutation__
 *
 * To run a mutation, you first call `useDeleteBlogMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteBlogMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteBlogMutation, { data, loading, error }] = useDeleteBlogMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteBlogMutation(baseOptions?: Apollo.MutationHookOptions<DeleteBlogMutation, DeleteBlogMutationVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useMutation<DeleteBlogMutation, DeleteBlogMutationVariables>(DeleteBlogDocument, options);
      }
export type DeleteBlogMutationHookResult = ReturnType<typeof useDeleteBlogMutation>;
export type DeleteBlogMutationResult = Apollo.MutationResult<DeleteBlogMutation>;
export type DeleteBlogMutationOptions = Apollo.BaseMutationOptions<DeleteBlogMutation, DeleteBlogMutationVariables>;
export const DeleteIntegrationDocument = gql`
    mutation DeleteIntegration($id: ID!) {
  deleteIntegration(id: $id)
}
    `;
export type DeleteIntegrationMutationFn = Apollo.MutationFunction<DeleteIntegrationMutation, DeleteIntegrationMutationVariables>;

/**
 * __useDeleteIntegrationMutation__
 *
 * To run a mutation, you first call `useDeleteIntegrationMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useDeleteIntegrationMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [deleteIntegrationMutation, { data, loading, error }] = useDeleteIntegrationMutation({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useDeleteIntegrationMutation(baseOptions?: Apollo.MutationHookOptions<DeleteIntegrationMutation, DeleteIntegrationMutationVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useMutation<DeleteIntegrationMutation, DeleteIntegrationMutationVariables>(DeleteIntegrationDocument, options);
      }
export type DeleteIntegrationMutationHookResult = ReturnType<typeof useDeleteIntegrationMutation>;
export type DeleteIntegrationMutationResult = Apollo.MutationResult<DeleteIntegrationMutation>;
export type DeleteIntegrationMutationOptions = Apollo.BaseMutationOptions<DeleteIntegrationMutation, DeleteIntegrationMutationVariables>;
export const CreatePresignedUrlDocument = gql`
    mutation CreatePresignedUrl($input: CreatePresignedUrlInput!) {
  createPresignedUrl(input: $input) {
    url
    key
  }
}
    `;
export type CreatePresignedUrlMutationFn = Apollo.MutationFunction<CreatePresignedUrlMutation, CreatePresignedUrlMutationVariables>;

/**
 * __useCreatePresignedUrlMutation__
 *
 * To run a mutation, you first call `useCreatePresignedUrlMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useCreatePresignedUrlMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [createPresignedUrlMutation, { data, loading, error }] = useCreatePresignedUrlMutation({
 *   variables: {
 *      input: // value for 'input'
 *   },
 * });
 */
export function useCreatePresignedUrlMutation(baseOptions?: Apollo.MutationHookOptions<CreatePresignedUrlMutation, CreatePresignedUrlMutationVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useMutation<CreatePresignedUrlMutation, CreatePresignedUrlMutationVariables>(CreatePresignedUrlDocument, options);
      }
export type CreatePresignedUrlMutationHookResult = ReturnType<typeof useCreatePresignedUrlMutation>;
export type CreatePresignedUrlMutationResult = Apollo.MutationResult<CreatePresignedUrlMutation>;
export type CreatePresignedUrlMutationOptions = Apollo.BaseMutationOptions<CreatePresignedUrlMutation, CreatePresignedUrlMutationVariables>;