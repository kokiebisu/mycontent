// Code generated by ent, DO NOT EDIT.

package ent

import (
	"context"
	"errors"
	"fmt"
	"time"

	"entgo.io/ent/dialect/sql"
	"entgo.io/ent/dialect/sql/sqlgraph"
	"entgo.io/ent/schema/field"
	"github.com/kokiebisu/mycontent/packages/service-blog/ent/blog"
	"github.com/kokiebisu/mycontent/packages/service-blog/ent/predicate"
)

// BlogUpdate is the builder for updating Blog entities.
type BlogUpdate struct {
	config
	hooks    []Hook
	mutation *BlogMutation
}

// Where appends a list predicates to the BlogUpdate builder.
func (bu *BlogUpdate) Where(ps ...predicate.Blog) *BlogUpdate {
	bu.mutation.Where(ps...)
	return bu
}

// SetTitle sets the "title" field.
func (bu *BlogUpdate) SetTitle(s string) *BlogUpdate {
	bu.mutation.SetTitle(s)
	return bu
}

// SetNillableTitle sets the "title" field if the given value is not nil.
func (bu *BlogUpdate) SetNillableTitle(s *string) *BlogUpdate {
	if s != nil {
		bu.SetTitle(*s)
	}
	return bu
}

// SetContent sets the "content" field.
func (bu *BlogUpdate) SetContent(s string) *BlogUpdate {
	bu.mutation.SetContent(s)
	return bu
}

// SetNillableContent sets the "content" field if the given value is not nil.
func (bu *BlogUpdate) SetNillableContent(s *string) *BlogUpdate {
	if s != nil {
		bu.SetContent(*s)
	}
	return bu
}

// SetUserID sets the "user_id" field.
func (bu *BlogUpdate) SetUserID(s string) *BlogUpdate {
	bu.mutation.SetUserID(s)
	return bu
}

// SetNillableUserID sets the "user_id" field if the given value is not nil.
func (bu *BlogUpdate) SetNillableUserID(s *string) *BlogUpdate {
	if s != nil {
		bu.SetUserID(*s)
	}
	return bu
}

// SetInterest sets the "interest" field.
func (bu *BlogUpdate) SetInterest(b blog.Interest) *BlogUpdate {
	bu.mutation.SetInterest(b)
	return bu
}

// SetNillableInterest sets the "interest" field if the given value is not nil.
func (bu *BlogUpdate) SetNillableInterest(b *blog.Interest) *BlogUpdate {
	if b != nil {
		bu.SetInterest(*b)
	}
	return bu
}

// SetUpdatedAt sets the "updated_at" field.
func (bu *BlogUpdate) SetUpdatedAt(t time.Time) *BlogUpdate {
	bu.mutation.SetUpdatedAt(t)
	return bu
}

// Mutation returns the BlogMutation object of the builder.
func (bu *BlogUpdate) Mutation() *BlogMutation {
	return bu.mutation
}

// Save executes the query and returns the number of nodes affected by the update operation.
func (bu *BlogUpdate) Save(ctx context.Context) (int, error) {
	bu.defaults()
	return withHooks(ctx, bu.sqlSave, bu.mutation, bu.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (bu *BlogUpdate) SaveX(ctx context.Context) int {
	affected, err := bu.Save(ctx)
	if err != nil {
		panic(err)
	}
	return affected
}

// Exec executes the query.
func (bu *BlogUpdate) Exec(ctx context.Context) error {
	_, err := bu.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (bu *BlogUpdate) ExecX(ctx context.Context) {
	if err := bu.Exec(ctx); err != nil {
		panic(err)
	}
}

// defaults sets the default values of the builder before save.
func (bu *BlogUpdate) defaults() {
	if _, ok := bu.mutation.UpdatedAt(); !ok {
		v := blog.UpdateDefaultUpdatedAt()
		bu.mutation.SetUpdatedAt(v)
	}
}

// check runs all checks and user-defined validators on the builder.
func (bu *BlogUpdate) check() error {
	if v, ok := bu.mutation.Interest(); ok {
		if err := blog.InterestValidator(v); err != nil {
			return &ValidationError{Name: "interest", err: fmt.Errorf(`ent: validator failed for field "Blog.interest": %w`, err)}
		}
	}
	return nil
}

func (bu *BlogUpdate) sqlSave(ctx context.Context) (n int, err error) {
	if err := bu.check(); err != nil {
		return n, err
	}
	_spec := sqlgraph.NewUpdateSpec(blog.Table, blog.Columns, sqlgraph.NewFieldSpec(blog.FieldID, field.TypeString))
	if ps := bu.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := bu.mutation.Title(); ok {
		_spec.SetField(blog.FieldTitle, field.TypeString, value)
	}
	if value, ok := bu.mutation.Content(); ok {
		_spec.SetField(blog.FieldContent, field.TypeString, value)
	}
	if value, ok := bu.mutation.UserID(); ok {
		_spec.SetField(blog.FieldUserID, field.TypeString, value)
	}
	if value, ok := bu.mutation.Interest(); ok {
		_spec.SetField(blog.FieldInterest, field.TypeEnum, value)
	}
	if value, ok := bu.mutation.UpdatedAt(); ok {
		_spec.SetField(blog.FieldUpdatedAt, field.TypeTime, value)
	}
	if n, err = sqlgraph.UpdateNodes(ctx, bu.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{blog.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return 0, err
	}
	bu.mutation.done = true
	return n, nil
}

// BlogUpdateOne is the builder for updating a single Blog entity.
type BlogUpdateOne struct {
	config
	fields   []string
	hooks    []Hook
	mutation *BlogMutation
}

// SetTitle sets the "title" field.
func (buo *BlogUpdateOne) SetTitle(s string) *BlogUpdateOne {
	buo.mutation.SetTitle(s)
	return buo
}

// SetNillableTitle sets the "title" field if the given value is not nil.
func (buo *BlogUpdateOne) SetNillableTitle(s *string) *BlogUpdateOne {
	if s != nil {
		buo.SetTitle(*s)
	}
	return buo
}

// SetContent sets the "content" field.
func (buo *BlogUpdateOne) SetContent(s string) *BlogUpdateOne {
	buo.mutation.SetContent(s)
	return buo
}

// SetNillableContent sets the "content" field if the given value is not nil.
func (buo *BlogUpdateOne) SetNillableContent(s *string) *BlogUpdateOne {
	if s != nil {
		buo.SetContent(*s)
	}
	return buo
}

// SetUserID sets the "user_id" field.
func (buo *BlogUpdateOne) SetUserID(s string) *BlogUpdateOne {
	buo.mutation.SetUserID(s)
	return buo
}

// SetNillableUserID sets the "user_id" field if the given value is not nil.
func (buo *BlogUpdateOne) SetNillableUserID(s *string) *BlogUpdateOne {
	if s != nil {
		buo.SetUserID(*s)
	}
	return buo
}

// SetInterest sets the "interest" field.
func (buo *BlogUpdateOne) SetInterest(b blog.Interest) *BlogUpdateOne {
	buo.mutation.SetInterest(b)
	return buo
}

// SetNillableInterest sets the "interest" field if the given value is not nil.
func (buo *BlogUpdateOne) SetNillableInterest(b *blog.Interest) *BlogUpdateOne {
	if b != nil {
		buo.SetInterest(*b)
	}
	return buo
}

// SetUpdatedAt sets the "updated_at" field.
func (buo *BlogUpdateOne) SetUpdatedAt(t time.Time) *BlogUpdateOne {
	buo.mutation.SetUpdatedAt(t)
	return buo
}

// Mutation returns the BlogMutation object of the builder.
func (buo *BlogUpdateOne) Mutation() *BlogMutation {
	return buo.mutation
}

// Where appends a list predicates to the BlogUpdate builder.
func (buo *BlogUpdateOne) Where(ps ...predicate.Blog) *BlogUpdateOne {
	buo.mutation.Where(ps...)
	return buo
}

// Select allows selecting one or more fields (columns) of the returned entity.
// The default is selecting all fields defined in the entity schema.
func (buo *BlogUpdateOne) Select(field string, fields ...string) *BlogUpdateOne {
	buo.fields = append([]string{field}, fields...)
	return buo
}

// Save executes the query and returns the updated Blog entity.
func (buo *BlogUpdateOne) Save(ctx context.Context) (*Blog, error) {
	buo.defaults()
	return withHooks(ctx, buo.sqlSave, buo.mutation, buo.hooks)
}

// SaveX is like Save, but panics if an error occurs.
func (buo *BlogUpdateOne) SaveX(ctx context.Context) *Blog {
	node, err := buo.Save(ctx)
	if err != nil {
		panic(err)
	}
	return node
}

// Exec executes the query on the entity.
func (buo *BlogUpdateOne) Exec(ctx context.Context) error {
	_, err := buo.Save(ctx)
	return err
}

// ExecX is like Exec, but panics if an error occurs.
func (buo *BlogUpdateOne) ExecX(ctx context.Context) {
	if err := buo.Exec(ctx); err != nil {
		panic(err)
	}
}

// defaults sets the default values of the builder before save.
func (buo *BlogUpdateOne) defaults() {
	if _, ok := buo.mutation.UpdatedAt(); !ok {
		v := blog.UpdateDefaultUpdatedAt()
		buo.mutation.SetUpdatedAt(v)
	}
}

// check runs all checks and user-defined validators on the builder.
func (buo *BlogUpdateOne) check() error {
	if v, ok := buo.mutation.Interest(); ok {
		if err := blog.InterestValidator(v); err != nil {
			return &ValidationError{Name: "interest", err: fmt.Errorf(`ent: validator failed for field "Blog.interest": %w`, err)}
		}
	}
	return nil
}

func (buo *BlogUpdateOne) sqlSave(ctx context.Context) (_node *Blog, err error) {
	if err := buo.check(); err != nil {
		return _node, err
	}
	_spec := sqlgraph.NewUpdateSpec(blog.Table, blog.Columns, sqlgraph.NewFieldSpec(blog.FieldID, field.TypeString))
	id, ok := buo.mutation.ID()
	if !ok {
		return nil, &ValidationError{Name: "id", err: errors.New(`ent: missing "Blog.id" for update`)}
	}
	_spec.Node.ID.Value = id
	if fields := buo.fields; len(fields) > 0 {
		_spec.Node.Columns = make([]string, 0, len(fields))
		_spec.Node.Columns = append(_spec.Node.Columns, blog.FieldID)
		for _, f := range fields {
			if !blog.ValidColumn(f) {
				return nil, &ValidationError{Name: f, err: fmt.Errorf("ent: invalid field %q for query", f)}
			}
			if f != blog.FieldID {
				_spec.Node.Columns = append(_spec.Node.Columns, f)
			}
		}
	}
	if ps := buo.mutation.predicates; len(ps) > 0 {
		_spec.Predicate = func(selector *sql.Selector) {
			for i := range ps {
				ps[i](selector)
			}
		}
	}
	if value, ok := buo.mutation.Title(); ok {
		_spec.SetField(blog.FieldTitle, field.TypeString, value)
	}
	if value, ok := buo.mutation.Content(); ok {
		_spec.SetField(blog.FieldContent, field.TypeString, value)
	}
	if value, ok := buo.mutation.UserID(); ok {
		_spec.SetField(blog.FieldUserID, field.TypeString, value)
	}
	if value, ok := buo.mutation.Interest(); ok {
		_spec.SetField(blog.FieldInterest, field.TypeEnum, value)
	}
	if value, ok := buo.mutation.UpdatedAt(); ok {
		_spec.SetField(blog.FieldUpdatedAt, field.TypeTime, value)
	}
	_node = &Blog{config: buo.config}
	_spec.Assign = _node.assignValues
	_spec.ScanValues = _node.scanValues
	if err = sqlgraph.UpdateNode(ctx, buo.driver, _spec); err != nil {
		if _, ok := err.(*sqlgraph.NotFoundError); ok {
			err = &NotFoundError{blog.Label}
		} else if sqlgraph.IsConstraintError(err) {
			err = &ConstraintError{msg: err.Error(), wrap: err}
		}
		return nil, err
	}
	buo.mutation.done = true
	return _node, nil
}
