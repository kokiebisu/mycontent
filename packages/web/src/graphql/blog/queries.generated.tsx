import * as Types from '../types';

import { gql } from '@apollo/client';
import * as Apollo from '@apollo/client';
const defaultOptions = {} as const;
export type GetBlogQueryVariables = Types.Exact<{
  id: Types.Scalars['ID']['input'];
}>;


export type GetBlogQuery = { __typename?: 'Query', blog: { __typename?: 'Blog', id: string, title: string, content: string } };

export type GetBlogsQueryVariables = Types.Exact<{ [key: string]: never; }>;


export type GetBlogsQuery = { __typename?: 'Query', blogs: Array<{ __typename?: 'Blog', id: string, title: string, content: string }> };

export type GetBlogsByUserIdQueryVariables = Types.Exact<{
  userId: Types.Scalars['ID']['input'];
}>;


export type GetBlogsByUserIdQuery = { __typename?: 'Query', blogsByUserId: Array<{ __typename?: 'Blog', id: string, title: string, content: string }> };

export type GetIntegrationQueryVariables = Types.Exact<{
  id: Types.Scalars['ID']['input'];
}>;


export type GetIntegrationQuery = { __typename?: 'Query', integration: { __typename?: 'Integration', id: string, platform: Types.Platform } };

export type GetIntegrationsByUserIdQueryVariables = Types.Exact<{
  userId: Types.Scalars['ID']['input'];
  platform: Types.Platform;
}>;


export type GetIntegrationsByUserIdQuery = { __typename?: 'Query', integrationsByUserId: Array<{ __typename?: 'Integration', id: string, platform: Types.Platform }> };


export const GetBlogDocument = gql`
    query GetBlog($id: ID!) {
  blog(id: $id) {
    id
    title
    content
  }
}
    `;

/**
 * __useGetBlogQuery__
 *
 * To run a query within a React component, call `useGetBlogQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetBlogQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetBlogQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetBlogQuery(baseOptions: Apollo.QueryHookOptions<GetBlogQuery, GetBlogQueryVariables> & ({ variables: GetBlogQueryVariables; skip?: boolean; } | { skip: boolean; }) ) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetBlogQuery, GetBlogQueryVariables>(GetBlogDocument, options);
      }
export function useGetBlogLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetBlogQuery, GetBlogQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetBlogQuery, GetBlogQueryVariables>(GetBlogDocument, options);
        }
export function useGetBlogSuspenseQuery(baseOptions?: Apollo.SuspenseQueryHookOptions<GetBlogQuery, GetBlogQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useSuspenseQuery<GetBlogQuery, GetBlogQueryVariables>(GetBlogDocument, options);
        }
export type GetBlogQueryHookResult = ReturnType<typeof useGetBlogQuery>;
export type GetBlogLazyQueryHookResult = ReturnType<typeof useGetBlogLazyQuery>;
export type GetBlogSuspenseQueryHookResult = ReturnType<typeof useGetBlogSuspenseQuery>;
export type GetBlogQueryResult = Apollo.QueryResult<GetBlogQuery, GetBlogQueryVariables>;
export const GetBlogsDocument = gql`
    query GetBlogs {
  blogs {
    id
    title
    content
  }
}
    `;

/**
 * __useGetBlogsQuery__
 *
 * To run a query within a React component, call `useGetBlogsQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetBlogsQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetBlogsQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetBlogsQuery(baseOptions?: Apollo.QueryHookOptions<GetBlogsQuery, GetBlogsQueryVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetBlogsQuery, GetBlogsQueryVariables>(GetBlogsDocument, options);
      }
export function useGetBlogsLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetBlogsQuery, GetBlogsQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetBlogsQuery, GetBlogsQueryVariables>(GetBlogsDocument, options);
        }
export function useGetBlogsSuspenseQuery(baseOptions?: Apollo.SuspenseQueryHookOptions<GetBlogsQuery, GetBlogsQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useSuspenseQuery<GetBlogsQuery, GetBlogsQueryVariables>(GetBlogsDocument, options);
        }
export type GetBlogsQueryHookResult = ReturnType<typeof useGetBlogsQuery>;
export type GetBlogsLazyQueryHookResult = ReturnType<typeof useGetBlogsLazyQuery>;
export type GetBlogsSuspenseQueryHookResult = ReturnType<typeof useGetBlogsSuspenseQuery>;
export type GetBlogsQueryResult = Apollo.QueryResult<GetBlogsQuery, GetBlogsQueryVariables>;
export const GetBlogsByUserIdDocument = gql`
    query GetBlogsByUserId($userId: ID!) {
  blogsByUserId(userId: $userId) {
    id
    title
    content
  }
}
    `;

/**
 * __useGetBlogsByUserIdQuery__
 *
 * To run a query within a React component, call `useGetBlogsByUserIdQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetBlogsByUserIdQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetBlogsByUserIdQuery({
 *   variables: {
 *      userId: // value for 'userId'
 *   },
 * });
 */
export function useGetBlogsByUserIdQuery(baseOptions: Apollo.QueryHookOptions<GetBlogsByUserIdQuery, GetBlogsByUserIdQueryVariables> & ({ variables: GetBlogsByUserIdQueryVariables; skip?: boolean; } | { skip: boolean; }) ) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetBlogsByUserIdQuery, GetBlogsByUserIdQueryVariables>(GetBlogsByUserIdDocument, options);
      }
export function useGetBlogsByUserIdLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetBlogsByUserIdQuery, GetBlogsByUserIdQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetBlogsByUserIdQuery, GetBlogsByUserIdQueryVariables>(GetBlogsByUserIdDocument, options);
        }
export function useGetBlogsByUserIdSuspenseQuery(baseOptions?: Apollo.SuspenseQueryHookOptions<GetBlogsByUserIdQuery, GetBlogsByUserIdQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useSuspenseQuery<GetBlogsByUserIdQuery, GetBlogsByUserIdQueryVariables>(GetBlogsByUserIdDocument, options);
        }
export type GetBlogsByUserIdQueryHookResult = ReturnType<typeof useGetBlogsByUserIdQuery>;
export type GetBlogsByUserIdLazyQueryHookResult = ReturnType<typeof useGetBlogsByUserIdLazyQuery>;
export type GetBlogsByUserIdSuspenseQueryHookResult = ReturnType<typeof useGetBlogsByUserIdSuspenseQuery>;
export type GetBlogsByUserIdQueryResult = Apollo.QueryResult<GetBlogsByUserIdQuery, GetBlogsByUserIdQueryVariables>;
export const GetIntegrationDocument = gql`
    query GetIntegration($id: ID!) {
  integration(id: $id) {
    id
    platform
  }
}
    `;

/**
 * __useGetIntegrationQuery__
 *
 * To run a query within a React component, call `useGetIntegrationQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetIntegrationQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetIntegrationQuery({
 *   variables: {
 *      id: // value for 'id'
 *   },
 * });
 */
export function useGetIntegrationQuery(baseOptions: Apollo.QueryHookOptions<GetIntegrationQuery, GetIntegrationQueryVariables> & ({ variables: GetIntegrationQueryVariables; skip?: boolean; } | { skip: boolean; }) ) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetIntegrationQuery, GetIntegrationQueryVariables>(GetIntegrationDocument, options);
      }
export function useGetIntegrationLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetIntegrationQuery, GetIntegrationQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetIntegrationQuery, GetIntegrationQueryVariables>(GetIntegrationDocument, options);
        }
export function useGetIntegrationSuspenseQuery(baseOptions?: Apollo.SuspenseQueryHookOptions<GetIntegrationQuery, GetIntegrationQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useSuspenseQuery<GetIntegrationQuery, GetIntegrationQueryVariables>(GetIntegrationDocument, options);
        }
export type GetIntegrationQueryHookResult = ReturnType<typeof useGetIntegrationQuery>;
export type GetIntegrationLazyQueryHookResult = ReturnType<typeof useGetIntegrationLazyQuery>;
export type GetIntegrationSuspenseQueryHookResult = ReturnType<typeof useGetIntegrationSuspenseQuery>;
export type GetIntegrationQueryResult = Apollo.QueryResult<GetIntegrationQuery, GetIntegrationQueryVariables>;
export const GetIntegrationsByUserIdDocument = gql`
    query GetIntegrationsByUserId($userId: ID!, $platform: Platform!) {
  integrationsByUserId(userId: $userId, platform: $platform) {
    id
    platform
  }
}
    `;

/**
 * __useGetIntegrationsByUserIdQuery__
 *
 * To run a query within a React component, call `useGetIntegrationsByUserIdQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetIntegrationsByUserIdQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetIntegrationsByUserIdQuery({
 *   variables: {
 *      userId: // value for 'userId'
 *      platform: // value for 'platform'
 *   },
 * });
 */
export function useGetIntegrationsByUserIdQuery(baseOptions: Apollo.QueryHookOptions<GetIntegrationsByUserIdQuery, GetIntegrationsByUserIdQueryVariables> & ({ variables: GetIntegrationsByUserIdQueryVariables; skip?: boolean; } | { skip: boolean; }) ) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetIntegrationsByUserIdQuery, GetIntegrationsByUserIdQueryVariables>(GetIntegrationsByUserIdDocument, options);
      }
export function useGetIntegrationsByUserIdLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetIntegrationsByUserIdQuery, GetIntegrationsByUserIdQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetIntegrationsByUserIdQuery, GetIntegrationsByUserIdQueryVariables>(GetIntegrationsByUserIdDocument, options);
        }
export function useGetIntegrationsByUserIdSuspenseQuery(baseOptions?: Apollo.SuspenseQueryHookOptions<GetIntegrationsByUserIdQuery, GetIntegrationsByUserIdQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useSuspenseQuery<GetIntegrationsByUserIdQuery, GetIntegrationsByUserIdQueryVariables>(GetIntegrationsByUserIdDocument, options);
        }
export type GetIntegrationsByUserIdQueryHookResult = ReturnType<typeof useGetIntegrationsByUserIdQuery>;
export type GetIntegrationsByUserIdLazyQueryHookResult = ReturnType<typeof useGetIntegrationsByUserIdLazyQuery>;
export type GetIntegrationsByUserIdSuspenseQueryHookResult = ReturnType<typeof useGetIntegrationsByUserIdSuspenseQuery>;
export type GetIntegrationsByUserIdQueryResult = Apollo.QueryResult<GetIntegrationsByUserIdQuery, GetIntegrationsByUserIdQueryVariables>;