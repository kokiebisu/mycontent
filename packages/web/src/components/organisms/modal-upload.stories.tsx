import type { Meta, StoryObj } from '@storybook/react';


import { UploadModalContent as UploadModal } from './modal-upload';
import React from 'react';
import { Dialog } from '../ui/dialog';

const ModalWrapper = ({ children }: { children: React.ReactNode }) => <Dialog open={true}>{children}</Dialog>

const meta: Meta<typeof UploadModal> = {
    title: 'Organisms/Modals/UploadModal',
    component: () => <ModalWrapper>
        <UploadModal jsonData={{}} onModalCloseClick={() => { }} />
    </ModalWrapper>
};

export default meta;
type Story = StoryObj<typeof UploadModal>;

export const Default: Story = {
    args: {
    },
};
