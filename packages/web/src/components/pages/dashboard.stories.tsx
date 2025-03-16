import type { Meta, StoryObj } from '@storybook/react';

import { Dashboard } from './dashboard';
import { blogHandlers } from '@/mocks/handlers/blog';

const meta: Meta<typeof Dashboard> = {
    title: 'Pages/Dashboard',
    component: Dashboard,
    parameters: {
        msw: {
            handlers: blogHandlers
        }
    }
};

export default meta;
type Story = StoryObj<typeof Dashboard>;

export const Default: Story = {
    args: {
    },
};
