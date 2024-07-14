package service

import (
	"context"
	"fmt"
	"time"

	"github.com/aws/aws-sdk-go-v2/service/s3"
)

type StorageService struct {
	client *s3.Client
}

func NewStorageService(client *s3.Client) *StorageService {
	return &StorageService{client:client}
}

func (s *StorageService) CreatePresignedUrl(ctx context.Context, bucketName, fileName, fileType string) (string, error) {
	presignClient := s3.NewPresignClient(s.client)
	
	input := &s3.PutObjectInput{
		Bucket:      &bucketName,
		Key:         &fileName,
		ContentType: &fileType,
	}
	
	request, err := presignClient.PresignPutObject(ctx, input, s3.WithPresignExpires(time.Minute*15))
	if err != nil {
		return "", fmt.Errorf("failed to presign request: %w", err)
	}
	
	return request.URL, nil
}
