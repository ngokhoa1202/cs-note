#hook #reactjs  #javascript  #jsx #functional-programming  #high-order-function  #event-driven-programming  #ajax #software-architecture 

# Common syntax
```JSX title='useMemo hook'
const cachedValue = useMemo(calculateValue, dependencies)
```
# Characteristics
- `useMemo` caches the result of a calculation between re-renders.
## Parameter
- `calculatedValue` is a function calculating the value that should be cached. It should be pure, should take no arguments, and should return a value of any type. On the first render, the function is executed. On next renders, the cached value is instantly returned if the `dependencies` have not changed since the last render.
- `dependencies` is  a list of all reactive values referenced inside of the `calculateValue` code. Reactive values include props, state, and all the variables and functions declared directly inside your component body.
# Usage
- `useMemo` is used to skip calculating computed states with heavy computations.
```JSX title='useMemo hook to skip unnecessary computations'
function ProductList({ products, filters, sortBy }) {
  // Heavy task: filtering + sorting 10,000+ products
  const processedProducts = useMemo(() => {
    return products
      .filter(product => {
        return product.price >= filters.minPrice &&
               product.price <= filters.maxPrice &&
               product.category.includes(filters.category) &&
               product.name.toLowerCase().includes(filters.search.toLowerCase());
      })
      .sort((a, b) => {
        switch(sortBy) {
          case 'price': return a.price - b.price;
          case 'rating': return b.rating - a.rating;
          default: return a.name.localeCompare(b.name);
        }
      });
  }, [products, filters, sortBy]); // Only recalculate when these change

  return <div>{processedProducts.map(product => <ProductCard key={product.id} product={product} />)}</div>;
}
```
- `useMemo` is also made use of skipping re-renders of child components.
```JSX title='useMemo is employed to skip re-render'
export default function TodoList({ todos, tab, theme }) {
  const visibleTodos = useMemo(() => filterTodos(todos, tab), [todos, tab]);
  const children = useMemo(() => <List items={visibleTodos} />, [visibleTodos]);
  return (
    <div className={theme}>
      {children}
    </div>
  );
}
```
# References
1. https://react.dev/reference/react/useMemo