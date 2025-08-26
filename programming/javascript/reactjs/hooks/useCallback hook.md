#hook #reactjs  #javascript  #jsx #functional-programming  #high-order-function  #event-driven-programming   #ajax #software-architecture 

# Common syntax
```Javascript title='useCallback syntax'
const cachedFn = useCallback(fn, dependencies)
```

# Characteristics
- `useCallback`  <mark class="hltr-yellow">caches a function definition</mark> between re-renders.
## Parameters
- `fn` is the cached function value. 
	- On the first render, the function definition is returned.
	- On subsequent renders, the function is only re-calculated if its dependencies are changed; otherwise, its already stored version is returned.
- `dependencies` is the list of all reactive values referenced inside of the `fn` code including props, state, and all the variables and functions declared directly inside your component body.
## Return type
- On the first render, the return value is the `fn` function argument.
- On the subsequent renders, the return value is either the newly calculated function or the already stored one.
# Usage
## Event handlers with complex logic
```Jsx title='useCallback for event handlers with complex logic'
const TaskManager = () => {
  const [tasks, setTasks] = useState([]);
  const [filter, setFilter] = useState('all');
  const [sortBy, setSortBy] = useState('date');

  const handleTaskUpdate = useCallback((taskId, updates) => {
    setTasks(currentTasks => 
      currentTasks.map(task => 
        task.id === taskId 
          ? { ...task, ...updates, lastModified: Date.now() }
          : task
      )
    );
    
    // Log analytics
    analytics.track('task_updated', { taskId, updates });
  }, []); // No dependencies needed due to functional state updates

  const handleTaskDelete = useCallback((taskId) => {
    setTasks(currentTasks => currentTasks.filter(task => task.id !== taskId));
    analytics.track('task_deleted', { taskId });
  }, []);

  const filteredAndSortedTasks = useMemo(() => {
    let filtered = tasks;
    
    if (filter !== 'all') {
      filtered = tasks.filter(task => task.status === filter);
    }
    
    return filtered.sort((a, b) => {
      if (sortBy === 'date') return b.lastModified - a.lastModified;
      if (sortBy === 'priority') return b.priority - a.priority;
      return a.title.localeCompare(b.title);
    });
  }, [tasks, filter, sortBy]);

  return (
    <TaskList 
      tasks={filteredAndSortedTasks}
      onTaskUpdate={handleTaskUpdate}
      onTaskDelete={handleTaskDelete}
    />
  );
};
```
## Custom hook implementation
```Jsx title='useCallback for custome hooks implementation'
const useApi = (endpoint) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchData = useCallback(async (params = {}) => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await fetch(`${endpoint}?${new URLSearchParams(params)}`);
      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }, [endpoint]);

  const reset = useCallback(() => {
    setData(null);
    setError(null);
    setLoading(false);
  }, []);

  return { data, loading, error, fetchData, reset };
};

// Usage in component
const UserProfile = ({ userId }) => {
  const { data, loading, fetchData } = useApi('/api/users');

  useEffect(() => {
    fetchData({ id: userId });
  }, [fetchData, userId]); // fetchData reference remains stable

  // Component implementation...
};
```
---
# References
1. https://react.dev/reference/react/useCallback for `useCallback` hook.