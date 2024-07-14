package port

import "context"

type StorageService interface {
	CreatePresignedUrl(ctx context.Context, bucketName, fileName string, fileType string) (string, error)
}