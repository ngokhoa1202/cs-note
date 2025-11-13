#react  #javascript  #api  #dom  #jsx 

# Common syntax
```Jsx title='memo API syntax'
const MemoizedComponent = memo(SomeComponent, arePropsEqual?)
```
# Characteristics
- `memo` helps skip re-rendering a component when its props are unchanged.
## Parameters
- `Component`is the component to memorize. The `memo` does not modify this component, but returns a new, memorized component instead. Any valid React component, including functions and `forwardRef`components, is accepted.
- `arePropsEqual` is an optional function that accepts two arguments: the component’s previous props, and its new props. It should return `true` if the old and new props are equal which means the component's behavior will remain the same. Otherwise it should return `false`.
## Return type
- `memo` returns a new React component, which behaves the same as the component provided to `memo` except that it is not always forcefully re-rendered when its parent is being re-rendered unless its props have changed.
# Usage
## Component wasteful re-render prevention
```Jsx title='memo to prevent wasteful re-renders'
import React, { memo, useState } from 'react';

const ExpensiveListItem = memo(({ item, onUpdate }) => {
  console.log(`Rendering item: ${item.id}`);
  
  return (
    <div className="list-item">
      <h3>{item.title}</h3>
      <p>{item.description}</p>
      <button onClick={() => onUpdate(item.id)}>
        Update Item
      </button>
    </div>
  );
});

const ProductList = () => {
  const [products, setProducts] = useState([
    { id: 1, title: 'Product A', description: 'Description A' },
    { id: 2, title: 'Product B', description: 'Description B' },
    { id: 3, title: 'Product C', description: 'Description C' }
  ]);
  const [searchTerm, setSearchTerm] = useState('');

  const handleUpdate = (itemId) => {
    setProducts(prev => prev.map(p => 
      p.id === itemId ? { ...p, title: `${p.title} (Updated)` } : p
    ));
  };

  return (
    <div>
      <input 
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        placeholder="Search products..."
      />
      {products.map(product => (
        <ExpensiveListItem 
          key={product.id}
          item={product}
          onUpdate={handleUpdate}
        />
      ))}
    </div>
  );
};
```
## Custom comparison logic
```Jsx title='custom comparison logic in the second optional argument of memo API'
const UserCard = memo(({ user, permissions, onEdit }) => {
  return (
    <div className="user-card">
      <img src={user.avatar} alt={user.name} />
      <h2>{user.name}</h2>
      <p>{user.email}</p>
      <div className="permissions">
        {permissions.map(permission => (
          <span key={permission} className="permission-tag">
            {permission}
          </span>
        ))}
      </div>
      <button onClick={() => onEdit(user.id)}>Edit User</button>
    </div>
  );
}, (prevProps, nextProps) => {
  // Custom comparison logic
  const userUnchanged = prevProps.user.id === nextProps.user.id &&
                       prevProps.user.name === nextProps.user.name &&
                       prevProps.user.email === nextProps.user.email;
  
  const permissionsUnchanged = prevProps.permissions.length === nextProps.permissions.length &&
                              prevProps.permissions.every((perm, index) => 
                                perm === nextProps.permissions[index]
                              );
  
  const onEditUnchanged = prevProps.onEdit === nextProps.onEdit;
  
  return userUnchanged && permissionsUnchanged && onEditUnchanged;
});
```
# References
1. https://react.dev/reference/react/memo