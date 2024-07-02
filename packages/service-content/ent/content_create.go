// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	"time"

	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
	"github.com/kokiebisu/mycontent/packages/service-content/ent/content"
)

// ContentCreate is the builder for creating a Content entity.
type ContentCreate struct {
	config
	mutation *ContentMutation
	hooks    []Hook
}

// SetContentType sets the "content_type" field.
func (cc *ContentCreate) SetContentType(s string) *ContentCreate {
	cc.mutation.SetContentType(s)
	return cc
}

// SetTitle sets the "title" field.
func (cc *ContentCreate) SetTitle(s string) *ContentCreate {
	cc.mutation.SetTitle(s)
	return cc
}

// SetCreator sets the "creator" field.
func (cc *ContentCreate) SetCreator(s string) *ContentCreate {
	cc.mutation.SetCreator(s)
	return cc
}

// SetImageURL sets the "image_url" field.
func (cc *ContentCreate) SetImageURL(s string) *ContentCreate {
	cc.mutation.SetImageURL(s)
	return cc
}

// SetUpdatedAt sets the "updated_at" field.
func (cc *ContentCreate) SetUpdatedAt(t time.Time) *ContentCreate {
	cc.mutation.SetUpdatedAt(t)
	return cc
}

// SetNillableUpdatedAt sets the "updated_at" field if the given value is not nil.
func (cc *ContentCreate) SetNillableUpdatedAt(t *time.Time) *ContentCreate {
	if t != nil {
		cc.SetUpdatedAt(*t)
	}
	return cc
}

// Mutation returns the ContentMutation object of the builder.
func (cc *ContentCreate) Mutation() *ContentMutation {
	return cc.mutation
}

// Save creates the Content in the database.
func (cc *ContentCreate) Save(ctx context.Context) (*Content, error) {
	cc.defaults()
	return withHooks(ctx, cc.sqlSave, cc.mutation, cc.hooks)
}

// SaveX calls Save and panics if Save returns an error.
func (cc *ContentCreate) SaveX(ctx context.Context) *Content {
	v, err := cc.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (cc *ContentCreate) Exec(ctx context.Context) error {
	_, err := cc.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (cc *ContentCreate) ExecX(ctx context.Context) {
	if err := cc.Exec(ctx); err != nil {
		panic(err)
	}
}

// defaults sets the default values of the builder before save.
func (cc *ContentCreate) defaults() {
	if _, ok := cc.mutation.UpdatedAt(); !ok {
		v := content.DefaultUpdatedAt()
		cc.mutation.SetUpdatedAt(v)
	}
}

// check runs all checks and user-defined validators on the builder.
func (cc *ContentCreate) check() error {
	if _, ok := cc.mutation.ContentType(); !ok {
		return &ValidationError{Name: "content_type", err: errors.New(`ent: missing required field "Content.content_type"`)}
	}
	if _, ok := cc.mutation.Title(); !ok {
		return &ValidationError{Name: "title", err: errors.New(`ent: missing required field "Content.title"`)}
	}
	if _, ok := cc.mutation.Creator(); !ok {
		return &ValidationError{Name: "creator", err: errors.New(`ent: missing required field "Content.creator"`)}
	}
	if _, ok := cc.mutation.ImageURL(); !ok {
		return &ValidationError{Name: "image_url", err: errors.New(`ent: missing required field "Content.image_url"`)}
	}
	if _, ok := cc.mutation.UpdatedAt(); !ok {
		return &ValidationError{Name: "updated_at", err: errors.New(`ent: missing required field "Content.updated_at"`)}
	}
	return nil
}

func (cc *ContentCreate) sqlSave(ctx context.Context) (*Content, error) {
	if err := cc.check(); err != nil {
		return nil, err
	}
	_node, _spec := cc.createSpec()
	if err := sqlgraph.CreateNode(ctx, cc.driver, _spec); err != nil {
		if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	id := _spec.ID.Value.(int64)
	_node.ID = int(id)
	cc.mutation.id = &_node.ID
	cc.mutation.done = true
	return _node, nil
}

func (cc *ContentCreate) createSpec() (*Content, *sqlgraph.CreateSpec) {
	var (
		_node = &Content{config: cc.config}
		_spec = sqlgraph.NewCreateSpec(content.Table, sqlgraph.NewFieldSpec(content.FieldID, field.TypeInt))
	)
	if value, ok := cc.mutation.ContentType(); ok {
		_spec.SetField(content.FieldContentType, field.TypeString, value)
		_node.ContentType = value
	}
	if value, ok := cc.mutation.Title(); ok {
		_spec.SetField(content.FieldTitle, field.TypeString, value)
		_node.Title = value
	}
	if value, ok := cc.mutation.Creator(); ok {
		_spec.SetField(content.FieldCreator, field.TypeString, value)
		_node.Creator = value
	}
	if value, ok := cc.mutation.ImageURL(); ok {
		_spec.SetField(content.FieldImageURL, field.TypeString, value)
		_node.ImageURL = value
	}
	if value, ok := cc.mutation.UpdatedAt(); ok {
		_spec.SetField(content.FieldUpdatedAt, field.TypeTime, value)
		_node.UpdatedAt = value
	}
	return _node, _spec
}

// ContentCreateBulk is the builder for creating many Content entities in bulk.
type ContentCreateBulk struct {
	config
	err      error
	builders []*ContentCreate
}

// Save creates the Content entities in the database.
func (ccb *ContentCreateBulk) Save(ctx context.Context) ([]*Content, error) {
	if ccb.err != nil {
		return nil, ccb.err
	}
	specs := make([]*sqlgraph.CreateSpec, len(ccb.builders))
	nodes := make([]*Content, len(ccb.builders))
	mutators := make([]Mutator, len(ccb.builders))
	for i := range ccb.builders {
		func(i int, root context.Context) {
			builder := ccb.builders[i]
			builder.defaults()
			var mut Mutator = MutateFunc(func(ctx context.Context, m Mutation) (Value, error) {
				mutation, ok := m.(*ContentMutation)
				if !ok {
					return nil, fmt.Errorf("unexpected mutation type %T", m)
				}
				if err := builder.check(); err != nil {
					return nil, err
				}
				builder.mutation = mutation
				var err error
				nodes[i], specs[i] = builder.createSpec()
				if i < len(mutators)-1 {
					_, err = mutators[i+1].Mutate(root, ccb.builders[i+1].mutation)
				} else {
					spec := &sqlgraph.BatchCreateSpec{Nodes: specs}
					// Invoke the actual operation on the latest mutation in the chain.
					if err = sqlgraph.BatchCreate(ctx, ccb.driver, spec); err != nil {
						if sqlgraph.IsConstraintError(err) {
							err = &ConstraintError{msg: err.Error(), wrap: err}
						}
					}
				}
				if err != nil {
					return nil, err
				}
				mutation.id = &nodes[i].ID
				if specs[i].ID.Value != nil {
					id := specs[i].ID.Value.(int64)
					nodes[i].ID = int(id)
				}
				mutation.done = true
				return nodes[i], nil
			})
			for i := len(builder.hooks) - 1; i >= 0; i-- {
				mut = builder.hooks[i](mut)
			}
			mutators[i] = mut
		}(i, ctx)
	}
	if len(mutators) > 0 {
		if _, err := mutators[0].Mutate(ctx, ccb.builders[0].mutation); err != nil {
			return nil, err
		}
	}
	return nodes, nil
}

// SaveX is like Save, but panics if an error occurs.
func (ccb *ContentCreateBulk) SaveX(ctx context.Context) []*Content {
	v, err := ccb.Save(ctx)
	if err != nil {
		panic(err)
	}
	return v
}

// Exec executes the query.
func (ccb *ContentCreateBulk) Exec(ctx context.Context) error {
	_, err := ccb.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (ccb *ContentCreateBulk) ExecX(ctx context.Context) {
	if err := ccb.Exec(ctx); err != nil {
		panic(err)
	}
}