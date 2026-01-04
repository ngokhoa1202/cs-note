#expressjs #javascript #vanilla-javascript #typescript #data-type #abstract-syntax-tree #npm #yarn 
#software-engineering #software-architecture 
# Initialize project
- Run `npx express-generator-typescript`
```Bash title='Generate express typescript project'
npx express-generator-typescript <PROJECT_NAME>
```

# Project structure
- Using `express-generator-typescript`.
```tree title='Project structure of express-generator-typescript'
/express-ts-app
│── /src
│   ├── /routes
│   │   ├── index.ts
│   │   ├── users.ts
│   │   ├── auth.ts
│   ├── /controllers
│   │   ├── user.controller.ts
│   │   ├── auth.controller.ts
│   ├── /middlewares
│   │   ├── auth.middleware.ts
│   ├── /models
│   │   ├── user.model.ts
│   ├── /services
│   │   ├── user.service.ts
│   ├── /config
│   │   ├── db.ts
│   │   ├── dotenv.ts
│   ├── app.ts
│   ├── server.ts
│── /dist (Generated JS files after `tsc` compilation)
│── /node_modules
│── .env
│── .gitignore
│── package.json
│── tsconfig.json
│── README.md
```


# References
1. https://www.npmjs.com/package/express-generator-typescript for `express-generator-typescript`.
2. https://github.com/w3cj/express-api-starter-ts for `express-api-starter-ts`.

