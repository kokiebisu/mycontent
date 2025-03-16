import type { Meta, StoryObj } from '@storybook/react';
import {
    LogOutIcon,
    UploadIcon,
    UserIcon,
    CloudUploadIcon,
    XIcon,
    ArrowLeftIcon
} from './icon';

// Create a wrapper component to display all icons
const IconGallery = () => {
    return (
        <div className="flex gap-4 flex-wrap">
            <div className="flex flex-col items-center gap-2">
                <LogOutIcon />
                <span>LogOut</span>
            </div>
            <div className="flex flex-col items-center gap-2">
                <UploadIcon />
                <span>Upload</span>
            </div>
            <div className="flex flex-col items-center gap-2">
                <UserIcon />
                <span>User</span>
            </div>
            <div className="flex flex-col items-center gap-2">
                <CloudUploadIcon />
                <span>CloudUpload</span>
            </div>
            <div className="flex flex-col items-center gap-2">
                <XIcon />
                <span>X</span>
            </div>
            <div className="flex flex-col items-center gap-2">
                <ArrowLeftIcon />
                <span>ArrowLeft</span>
            </div>
        </div>
    );
};

// Main meta configuration
const meta = {
    title: 'Atoms/Icons',
    // You can use the gallery as the default story
    component: IconGallery,
} satisfies Meta;

export default meta;

// Gallery story showing all icons
export const Gallery: StoryObj = {};

// Individual icon stories
export const Logout: StoryObj<typeof LogOutIcon> = {
    render: () => <LogOutIcon />
};

export const Upload: StoryObj<typeof UploadIcon> = {
    render: () => <UploadIcon />
};

export const User: StoryObj<typeof UserIcon> = {
    render: () => <UserIcon />
};

export const CloudUpload: StoryObj<typeof CloudUploadIcon> = {
    render: () => <CloudUploadIcon />
};

export const X: StoryObj<typeof XIcon> = {
    render: () => <XIcon />
};

export const ArrowLeft: StoryObj<typeof ArrowLeftIcon> = {
    render: () => <ArrowLeftIcon />
};

// Example of an icon with different sizes
export const WithCustomSize: StoryObj<typeof LogOutIcon> = {
    render: () => (
        <div className="flex gap-4">
            <LogOutIcon className="w-4 h-4" />
            <LogOutIcon className="w-6 h-6" />
            <LogOutIcon className="w-8 h-8" />
            <LogOutIcon className="w-12 h-12" />
        </div>
    )
};

// Example of an icon with different colors
export const WithCustomColors: StoryObj<typeof LogOutIcon> = {
    render: () => (
        <div className="flex gap-4">
            <LogOutIcon className="text-blue-500" />
            <LogOutIcon className="text-red-500" />
            <LogOutIcon className="text-green-500" />
            <LogOutIcon className="text-yellow-500" />
        </div>
    )
};
