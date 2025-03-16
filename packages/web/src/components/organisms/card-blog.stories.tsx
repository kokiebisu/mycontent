import type { Meta, StoryObj } from '@storybook/react';

import { BlogCard } from './card-blog';

const meta: Meta<typeof BlogCard> = {
    title: 'Organisms/Cards/BlogCard',
    component: BlogCard,
};

export default meta;
type Story = StoryObj<typeof BlogCard>;

export const Default: Story = {
    args: {
        title: 'Blog Title',
        description: 'Blog Description',
        content: 'Blog Content',
        status: 'published',
    },
};
