import { useState } from "react";
import {
  Dialog,
  DialogTrigger,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { CloudUploadIcon } from "./icon";

const UploadModal = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [jsonData, setJsonData] = useState(null);
  return (
    <Dialog open={isOpen} onOpenChange={setIsOpen} defaultOpen>
      <DialogTrigger asChild>
        <Button variant="outline">Upload JSON</Button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[600px]">
        <DialogHeader>
          <DialogTitle>Upload JSON File</DialogTitle>
          <DialogDescription>
            Drag and drop a JSON file to view its contents.
          </DialogDescription>
        </DialogHeader>
        <div className="flex justify-center items-center h-[300px] border-2 border-dashed border-muted rounded-lg">
          {jsonData ? (
            <div className="prose max-w-none">
              <pre>
                <code>{JSON.stringify(jsonData, null, 2)}</code>
              </pre>
            </div>
          ) : (
            <div>
              <div className="text-center space-y-2">
                <CloudUploadIcon className="w-12 h-12 mx-auto text-muted" />
                <p>Drag and drop a JSON file here</p>
                <p className="text-muted-foreground text-sm">
                  or click to select a file
                </p>
              </div>
            </div>
          )}
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => setIsOpen(false)}>
            Close
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
};

export default UploadModal;
