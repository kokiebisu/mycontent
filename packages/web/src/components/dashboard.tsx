import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import Link from "next/link";
import BlogCard from "./blog";
import {
  Dialog,
  DialogContent,
  DialogTitle,
  DialogDescription,
} from "@radix-ui/react-dialog";
import { useState, useCallback } from "react";
import { DialogHeader, DialogFooter } from "./ui/dialog";
import {
  CloudUploadIcon,
  LogOutIcon,
  UploadIcon,
  UserIcon,
  XIcon,
} from "./icon";
import { useCreatePresignedUrlMutation } from "@/graphql/blog";
import { useApolloClient } from "@apollo/client";
import { MeDocument } from "@/graphql/user";

interface DashboardInterface {
  onLogout: () => void;
}

const Dashboard = ({ onLogout }: DashboardInterface) => {
  const client = useApolloClient();
  const userData = client.readQuery({ query: MeDocument });
  const [createPresignedUrl] = useCreatePresignedUrlMutation();
  const [isOpen, setIsOpen] = useState(false);
  const [uploadedFile, setUploadedFile] = useState<{
    name: string;
    data: any;
  } | null>(null);

  const [blogPosts, setBlogPosts] = useState([
    {
      id: 1,
      title: "First Blog Post",
      description: "This is the first blog post.",
      content: "Content of the first blog post.",
      status: "published",
    },
    {
      id: 2,
      title: "Second Blog Post",
      description: "This is the second blog post.",
      content: "Content of the second blog post.",
      status: "draft",
    },
    {
      id: 3,
      title: "Third Blog Post",
      description: "This is the third blog post.",
      content: "Content of the third blog post.",
      status: "published",
    },
    {
      id: 4,
      title: "Fourth Blog Post",
      description: "This is the fourth blog post.",
      content: "Content of the fourth blog post.",
      status: "draft",
    },
    {
      id: 5,
      title: "Fifth Blog Post",
      description: "This is the fifth blog post.",
      content: "Content of the fifth blog post.",
      status: "published",
    },
    {
      id: 6,
      title: "Sixth Blog Post",
      description: "This is the sixth blog post.",
      content: "Content of the sixth blog post.",
      status: "draft",
    },
  ]);

  const handleUpload = async () => {
    if (!uploadedFile || !userData?.me?.id) {
      console.error("Missing required data for upload");
      return;
    }

    try {
      const result = await createPresignedUrl({
        variables: {
          input: {
            bucketName: "mycontent-assets",
            fileName: `conversations/user/${userData.me.id}/${uploadedFile.name}`,
            fileType: "application/json",
          },
        },
      });

      if (result.data?.createPresignedUrl?.url) {
        const presignedUrl = result.data.createPresignedUrl.url;

        try {
          const response = await fetch(presignedUrl, {
            method: "PUT",
            body: JSON.stringify(uploadedFile.data),
            headers: {
              "Content-Type": "application/json",
            },
          });

          if (response.ok) {
            console.log("File uploaded successfully");
            setUploadedFile(null);
            setIsOpen(false);
          } else {
            console.error("Failed to upload file:", response.statusText);
          }
        } catch (uploadError) {
          console.error("Error uploading file:", uploadError);
        }
      } else {
        console.error("No presigned URL received");
      }
      console.log("Presigned URL created successfully: ", result);
      // Add logic here to actually upload the file using the presigned URL
    } catch (error) {
      console.log("ERROR: ", error);
      console.error("Error creating presigned URL:", error);
    }
  };

  const handleDrop = useCallback((files: FileList) => {
    if (files.length > 0) {
      const file = files[0];
      if (file.type === "application/json") {
        handleFileRead(file);
      } else {
        console.error("Dropped file is not a JSON file");
      }
    }
  }, []);

  const handleDragOver = useCallback(
    (event: React.DragEvent<HTMLDivElement>) => {
      event.preventDefault();
    },
    []
  );

  const handleDragEnter = useCallback(
    (event: React.DragEvent<HTMLDivElement>) => {
      event.preventDefault();
    },
    []
  );

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file && file.type === "application/json") {
      handleFileRead(file);
    } else {
      console.error("Selected file is not a JSON file");
    }
  };

  const handleFileRead = (file: File) => {
    const reader = new FileReader();
    reader.onload = () => {
      try {
        const data = JSON.parse(reader.result as string);
        setUploadedFile({ name: file.name, data });
      } catch (error) {
        console.error("Error parsing JSON file:", error);
      }
    };
    reader.readAsText(file);
  };

  const removeUploadedFile = () => {
    setUploadedFile(null);
  };

  return (
    <>
      <div className="flex flex-col min-h-screen w-full">
        <header className="flex items-center justify-between bg-background px-4 py-3 shadow-sm sm:px-6">
          <div className="flex items-center gap-4">
            <Link href="#" className="text-lg font-bold" prefetch={false}>
              mycontent
            </Link>
          </div>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="ghost" size="icon" className="rounded-full">
                <Avatar className="h-8 w-8">
                  <AvatarImage src="/placeholder-user.jpg" />
                  <AvatarFallback>JP</AvatarFallback>
                </Avatar>
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end">
              <DropdownMenuItem onSelect={() => setIsOpen(true)}>
                <button className="flex items-center gap-2 w-full text-left">
                  <UploadIcon className="h-4 w-4" />
                  Upload JSON
                </button>
              </DropdownMenuItem>
              <DropdownMenuItem>
                <Link
                  href="/profile"
                  className="flex items-center gap-2"
                  prefetch={false}
                >
                  <UserIcon className="h-4 w-4" />
                  <span>Profile</span>
                </Link>
              </DropdownMenuItem>
              <DropdownMenuSeparator />
              <DropdownMenuItem>
                <button
                  onClick={onLogout}
                  className="flex items-center gap-2 w-full text-left"
                >
                  <LogOutIcon className="h-4 w-4" />
                  <span>Logout</span>
                </button>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </header>
        <main className="flex-1 p-4 sm:p-6">
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {blogPosts.map((post) => (
              <BlogCard
                key={post.id}
                title={post.title}
                description={post.description}
                content={post.content}
                status={post.status as "published" | "draft"}
              />
            ))}
          </div>
        </main>
      </div>

      <Dialog open={isOpen} onOpenChange={setIsOpen}>
        <DialogContent
          className="fixed inset-0 flex items-center justify-center bg-black/50 backdrop-blur-sm"
          onClick={() => setIsOpen(false)}
        >
          <div
            className="bg-background p-6 rounded-lg shadow-lg max-w-[600px] w-full max-h-[90vh] overflow-y-auto"
            onClick={(e) => e.stopPropagation()}
          >
            <DialogHeader>
              <DialogTitle>Upload JSON File</DialogTitle>
              <DialogDescription>
                Select a JSON file to upload.
              </DialogDescription>
            </DialogHeader>
            <div
              onDrop={(e) => {
                e.preventDefault();
                handleDrop(e.dataTransfer.files);
              }}
              onDragOver={handleDragOver}
              onDragEnter={handleDragEnter}
              className="flex justify-center items-center h-[200px] border-2 border-dashed border-muted rounded-lg mb-4"
            >
              {uploadedFile ? (
                <div className="flex items-center gap-2">
                  <p className="font-semibold">{uploadedFile.name}</p>
                  <button
                    onClick={removeUploadedFile}
                    className="flex items-center gap-1 text-sm text-muted-foreground hover:text-muted"
                  >
                    <XIcon className="h-4 w-4" />
                    <span>Remove</span>
                  </button>
                </div>
              ) : (
                <div className="text-center space-y-2">
                  <CloudUploadIcon className="w-12 h-12 mx-auto text-muted" />
                  <p>Drag and drop a JSON file here</p>
                  <p className="text-muted-foreground text-sm">
                    or click to select a file
                  </p>
                </div>
              )}
            </div>
            <input
              id="file-upload"
              type="file"
              accept="application/json"
              onChange={handleFileSelect}
              className="hidden"
            />
            <DialogFooter className="flex justify-end space-x-2 mt-4">
              <Button variant="outline" onClick={() => setIsOpen(false)}>
                Close
              </Button>
              <Button disabled={!uploadedFile} onClick={handleUpload}>
                Upload
              </Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
};

export default Dashboard;
