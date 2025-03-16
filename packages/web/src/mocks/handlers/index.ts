import { blogHandlers } from "./blog";
import { userHandlers } from "./user";

export const handlers = [
    ...blogHandlers,
    ...userHandlers
]
