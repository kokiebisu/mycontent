import { MeDocument } from '@/graphql/user'
import { graphql, HttpResponse } from 'msw'

export const userHandlers = [
    graphql.query(MeDocument, (data) => {
        return HttpResponse.json({
            data: {
                me: {
                    id: '123',
                    firstName: 'John',
                    lastName: 'Doe',
                    email: 'john.doe@example.com'
                }
            }
        })
    }),
]
