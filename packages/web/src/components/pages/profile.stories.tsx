import type { Meta, StoryObj } from '@storybook/react';

import { Profile } from './profile';
import { userHandlers } from '@/mocks/handlers/user';
import { graphql } from 'graphql';

const meta: Meta<typeof Profile> = {
    title: 'Pages/Profile',
    component: Profile,
    parameters: {
        msw: {
            handlers: userHandlers
        }
    }
};

export default meta;
type Story = StoryObj<typeof Profile>;

export const Default: Story = {
};
