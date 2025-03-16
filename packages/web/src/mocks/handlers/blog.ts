import { GetBlogsDocument } from '@/graphql/blog'
import { graphql, HttpResponse } from 'msw'

export const blogHandlers = [
    graphql.query(GetBlogsDocument, (data) => {
        return HttpResponse.json({
            data: {
                blogs: [
                    {
                        id: '123',
                        title: 'Blog 1',
                        content: 'Content 1'
                    }
                ]
            }
        })
    }),
]
