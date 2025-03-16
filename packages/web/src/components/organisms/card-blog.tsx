import Link from "next/link";
import {
  Card,
  CardHeader,
  CardTitle,
  CardContent,
  CardFooter,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

interface BlogCardInterface {
  title: string;
  content: string;
}

export const BlogCard = ({
  title,
  content,
}: BlogCardInterface) => (
  <Card>
    <CardHeader>
      <div className="flex justify-between items-center">
        <CardTitle>{title}</CardTitle>
        <Badge variant={status === "published" ? "default" : "secondary"}>
          {status === "published" ? "Published" : "Draft"}
        </Badge>
      </div>
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

