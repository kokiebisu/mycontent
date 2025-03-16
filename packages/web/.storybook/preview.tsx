import React from 'react'
import { initialize, mswLoader } from 'msw-storybook-addon'
import { ApolloProvider } from '@apollo/client'
import { client } from '../src/lib/apollo'
import '../src/app/globals.css'

initialize()

export const loaders = [mswLoader]


// Add Apollo provider decorator
export const decorators = [
  (Story) => (
    <ApolloProvider client={client}>
      <Story />
    </ApolloProvider>
  ),
];

export const parameters = {
  controls: {
    matchers: {
      color: /(background|color)$/i,
      date: /Date$/i,
    },
  },
}
