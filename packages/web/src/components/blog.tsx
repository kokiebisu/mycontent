import Link from "next/link";
import {
  Card,
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
  CardFooter,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

interface BlogCardInterface {
  title: string;
  description: string;
  content: string;
  status: "published" | "draft";
}

const BlogCard = ({
  title,
  description,
  content,
  status,
}: BlogCardInterface) => (
  <Card>
    <CardHeader>
      <div className="flex justify-between items-center">
        <CardTitle>{title}</CardTitle>
        <Badge variant={status === "published" ? "default" : "secondary"}>
          {status === "published" ? "Published" : "Draft"}
        </Badge>
      </div>
      <CardDescription>{description}</CardDescription>
    </CardHeader>
    <CardContent>
      <p>{content}</p>
    </CardContent>
    <CardFooter>
      <Link href="#" className="text-sm font-medium" prefetch={false}>
        Read more
      </Link>
    </CardFooter>
  </Card>
);

export default BlogCard;
