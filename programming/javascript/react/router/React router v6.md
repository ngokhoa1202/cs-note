#react #router #javascript 
# React router v6
- Use `createBrowserRouter` function instead of `BrowserRouter`

```javascript
const router = createBrowserRouter(
  createRoutesFromElements(

	<Route path="/" element={<Outlet />}>
	
		<Route path="admin" element={<Outlet />}>
	
			<Route path="dashboard" index={true} element={<Dashboard />}></Route>
	
			<Route
			
			path="/admin"
			
			loader={async () => redirect("/admin/dashboard")}
			>			</Route>
	
	</Route>
	
	<Route path="/" element={<Homepage />}></Route>
	
	</Route>

)

);
```

- `<Route>` component can be nested to specify a router:
	- Each `Route` child is equivalent to a URL.
	- If the child url is empty or any other characters, we should leave it at the end of parent `Route` and must specify the full url like `/{parent-full-url}` or `/{parent-full-url}/*`.
# Redirect
- Use `loader` property and pass an asynchronous callback to it:
	- The asynchronous function should `redirect` to another url and may pass addtional parameters.
- 