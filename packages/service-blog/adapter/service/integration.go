package service

import (
	"context"

	"github.com/google/uuid"
	"github.com/kokiebisu/mycontent/packages/service-blog/ent"
	"github.com/kokiebisu/mycontent/packages/service-blog/ent/integration"
	"github.com/kokiebisu/mycontent/packages/service-blog/port"
)

type IntegrationService struct {
	db *ent.Client
}

func NewIntegrationService(db *ent.Client) port.IntegrationService {
	return &IntegrationService{db: db}
}

func (s *IntegrationService) Create(ctx context.Context, integration *ent.Integration) (*ent.Integration, error) {
	createdIntegration, err := s.db.Integration.Create().
		SetPlatform(integration.Platform).
		SetAPIKey(integration.APIKey).
		SetUserID(integration.UserID).
		Save(ctx)
	if err != nil {
		return nil, err
	}
	return createdIntegration, nil
}

func (s *IntegrationService) Get(ctx context.Context, id string) (*ent.Integration, error) {
	uuidParsed, err := uuid.Parse(id)
	if err != nil {
		return nil, err
	}
	integration, err := s.db.Integration.Query().
		Where(integration.ID(uuidParsed)).
		First(ctx)
	if err != nil {
		return nil, err
	}
	return integration, nil
}

func (s *IntegrationService) Delete(ctx context.Context, id string) error {
	uuidParsed, err := uuid.Parse(id)
	if err != nil {
		return err
	}
	_, err = s.db.Integration.Delete().
		Where(integration.ID(uuidParsed)).
		Exec(ctx)
	if err != nil {
		return err
	}
	return nil
}

func (s *IntegrationService) GetAllByUserId(ctx context.Context, userID string) ([]*ent.Integration, error) {
	uuidParsed, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}
	integrations, err := s.db.Integration.Query().
		Where(integration.UserID(uuidParsed)).
		All(ctx)
	if err != nil {
		return nil, err
	}
	return integrations, nil
}

func (s *IntegrationService) GetByUserID(ctx context.Context, userID string) ([]*ent.Integration, error) {
	uuidParsed, err := uuid.Parse(userID)
	if err != nil {
		return nil, err
	}
	integrations, err := s.db.Integration.Query().
		Where(integration.UserID(uuidParsed)).
		All(ctx)
	if err != nil {
		return nil, err
	}
	return integrations, nil
}