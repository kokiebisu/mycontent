import NextLink from 'next/link';
import { ReactNode } from 'react';

interface LinkProps {
    href: string;
    children: ReactNode;
    className?: string;
    prefetch?: boolean;
    // Other props you might need
}

export const Link = ({
    href,
    children,
    className,
    prefetch = false,
    ...props
}: LinkProps) => {
    return (
        <NextLink
            href={href}
            className={className}
            prefetch={prefetch}
            {...props}
        >
            {children}
        </NextLink>
    );
};
