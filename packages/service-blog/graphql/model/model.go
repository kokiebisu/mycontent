// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package model

type CreatePresignedURLInput struct {
	BucketName string `json:"bucketName"`
	FileName   string `json:"fileName"`
	FileType   string `json:"fileType"`
}

type PresignedURLResponse struct {
	URL string `json:"url"`
	Key string `json:"key"`
}
