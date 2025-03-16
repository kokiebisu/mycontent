import type { Meta, StoryObj } from '@storybook/react';

import { ProfileTemplate } from './profile';

const meta: Meta<typeof ProfileTemplate> = {
    title: 'Templates/Profile',
    component: ProfileTemplate,
};

export default meta;
type Story = StoryObj<typeof ProfileTemplate>;

export const Default: Story = {
    args: {
    },
};
