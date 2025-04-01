#expressjs #javascript #nodejs #typescript #web-server #web #router #http #application-layer #computer-network #software-engineering #software-architecture #reactive-programming #design-pattern #behavioral-pattern #structural-pattern #reactive-programming 

# Routing methods
- [HTTP Methods](HTTP%20Methods.md) are supported by Express Js framework.
```Javascript title='Routing methods in Express'
app.get('/', (req, res) => {
  res.send('Hello World!')
});

app.post('/', (req, res) => {
  res.send('Got a POST request')
});

app.put('/user', (req, res) => {
  res.send('Got a PUT request at /user')
});

app.delete('/user', (req, res) => {
  res.send('Got a DELETE request at /user')
});
...
```

# Paths based on regular expression
```Javascript title='Express Js path based on regex'
app.get(/.*fly$/, (req, res) => {
  res.send('/.*fly$/')
})
```

# Route request parameters
```Javascript title='Route parameter definition'
app.get('/users/:userId/books/:bookId', (req, res) => {
  res.send(req.params)
});
```

- This route request is defined as
```Http title='Route request'
Route path: /users/:userId/books/:bookId
Request URL: http://localhost:3000/users/34/books/8989
req.params: { "userId": "34", "bookId": "8989" }
```

# Route handlers
---
# References
1. https://expressjs.com/en/guide/routing.html for Express Js routing methods.